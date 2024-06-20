<?php

namespace App\Http\Controllers;

use App\Http\Requests\ProfileUpdateRequest;
use App\Mail\OtpMail;
use App\Models\Employer;
use App\Models\Notifications;
use App\Models\OtpCode;
use App\Models\ScheduledTask;
use App\Models\Setting;
use App\Models\Skill;
use App\Models\User;
use App\Providers\RouteServiceProvider;
use Illuminate\Auth\Events\Registered;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;
use Illuminate\Validation\Rules;
use Psy\Util\Str;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;
use DB;
use Hash;

class UserController extends Controller
{
    function __construct()
    {
        $this->middleware('permission:user-list|user-create|user-edit|user-delete', ['only' => ['index']]);
        $this->middleware('permission:user-create', ['only' => ['store', 'create']]);
        $this->middleware('permission:user-edit', ['only' => ['update', 'updateProfileSkills']]);
        $this->middleware('permission:user-delete', ['only' => ['destroy', 'groupDelete', 'removeSkill']]);
    }

    public function checkUserExists(Request $request)
    {
        // Validate the request input
        $request->validate([
            'email' => 'required|email',
        ]);

        // Check if the user exists in the users table
        $userExists = \App\Models\User::where('email', $request->email)->exists();

        if ($userExists) {
            return response()->json(['status' => 200, 'exists' => true]);
        }

        return response()->json(['status' => 200, 'exists' => false]);
    }

    public function resendOtp(Request $request)
    {
        $otp = str_pad(rand(0, 9999), 4, '0', STR_PAD_LEFT);
        Mail::to($request->email)->send(new OtpMail($otp));
        $expiresAt = now()->addMinutes(1); // Set expiration time to 10 minutes from now

        \Illuminate\Support\Facades\DB::table('otp_codes')
            ->updateOrInsert(
                ['email' => $request->email],
                ['otp_code' => $otp, 'created_at' => now(), 'expired_at' => $expiresAt]
            );
        return response()->json(['message' => 'OTP code sent successfully'], 200);
    }

    public function isOtpVerified(Request $request)
    {
        // Validate the request input
        $request->validate([
            'email' => 'required|email|unique:users|max:148',
        ]);

        // Use Eloquent to retrieve the OTP code record
        $otpCode = OtpCode::where('email', $request->email);

        // Check if the OTP exists
        if ($otpCode->where('expired_at', '<', now())->exists()) {
            OtpCode::where('id', $otpCode->first()->id)->delete();
            return response()->json(['status' => 909, 'message' => 'OTP expired'], 400);
        }

        // Check if the OTP is verified
        if ($otpCode->where('expired_at', '>', now())->first()) {
            if (is_null($otpCode->verified_at)) {
                return response()->json(['status' => 909, 'verified' => false]);
            } else {
                return response()->json(['status' => 200, 'verified' => true]);
            }
        }else if (OtpCode::where('email', $request->email)->where('expired_at', '>', now())->whereNotNull('verified_at')->first()){
            return response()->json(['status' => 201, 'message' => 'Wait a minute'], 400);
        }else{
            return response()->json(['status' => 909, 'verified' => false]);

        }
    }

    public function verifyOtp(Request $request)
    {
        $request->validate([
            'otp' => 'required',
            'email' => 'required|email',
        ]);

        $otpCode = OtpCode::where('email', $request->email)
            ->where('otp_code', $request->otp)
            ->where('expired_at', '>', now()) // Check if OTP code is not expired
            ->first();

        if ($otpCode) {
            if (is_null($otpCode->verified_at)) {

                $otpCode->verified_at = now();
                $otpCode->save();

                return response()->json(['status' => 200]);
            } else {

                OtpCode::where('id', $otpCode->id)->delete();
            }
        }

        return response()->json(['message' => 'Invalid OTP code']);
    }

    public function index(Request $request)
    {
        $data = User::all();
        $employers = Employer::pluck('user_id', 'user_id')->all();
        $q = DB::table('employers')->join('users', 'employers.user_id', 'users.id')
            ->select('users.*')->orderBy('users.id')->get();
        $allData = $data->concat($employers);
//        dd($allData);
        /// where user id
        return \inertia('Accounts/Overview', ['users' => $data, 'employers' => $employers])
            ->with('i', ($request->input('page', 1) - 1) * 5);
    }

    public function create()
    {
        $allRoles = Role::pluck('name', 'name')->all();
        $allPermissions = Permission::orderBy('name', 'DESC')->pluck('name', 'name')->all();

        return \inertia('Accounts/Create', ['allRoles' => $allRoles, 'allPermissions' => $allPermissions]);
    }

    public function edit($uId)
    {
        $user = User::findOrFail($uId);
        $roles = Role::pluck('name', 'name')->all();
        $allPermissions = Permission::orderBy('name', 'DESC')->pluck('name', 'name')->all();
        $addedPermissions = \App\Models\Role::getDirectPermission($uId);

        $userRole = $user->roles->pluck('name', 'name')->all();//dd($userRole->name);
        return \inertia('Accounts/Edit', ['user' => $user, 'userRole' => $userRole, 'roles' => $roles, 'allPermissions' => $allPermissions, 'addedPermissions' => $addedPermissions, 'userPermissions' => $user->getAllPermissions()]);
    }

    public function store(Request $request)
    {
//        dd(Setting::generateUniqueToken(Setting::class,'frame_token',60));
        $request->validate([
            'name' => 'required|max:78',
            'email' => 'required|email|unique:users|max:148',
//            'password' => 'required|confirmed|max:2048',
            'password' => ['required', 'confirmed', Rules\Password::defaults()],

            'img' => 'image|mimes:jpeg,png,jpg|max:2048|nullable',
        ]);
        //// Roles
        if (isset($request->role)) {
            $selectedRoles = $request->role;
            // dd($request->all());

            foreach ($selectedRoles as $roleName) {
                $role = Role::where('name', $roleName)->first();
            }
        }

        $imageName = null;
        if ($request->img !== null) {
            $imageName = $request->img->getClientOriginalName();
            $request->img->move(public_path('/img/avatar'), $imageName);
        }
        $user = new User();
        $user->subscription_end_date = now()->addMonths(1); // Set the end date to one month from now
        $user->name = $request->name;
        $user->email = $request->email;
        $user->password = bcrypt($request->password);
        $user->job = $request->job;
        $user->city = $request->city;
        $user->address = $request->address;
        $user->description = $request->description;
        $user->lang = $request->lang;
            $user->givePermissionTo([$request->permissions]) ?? '';
        if ($imageName !== null) {
            $user->avatar = '/img/avatar/' . $imageName;
        }
        if ($user->save()) {
//            $user->assignRole(10);
            if (isset($role)) {
                $user->assignRole($role);
            }
            $string = 'xSf1pvnMobVx15mjcCKS';
            $shuffled = str_shuffle($string);
            $setting = new Setting();
            $setting->userId = $user->id;
            $setting->api_token = $shuffled;
            $setting->frame_token = Setting::generateUniqueToken(Setting::class, 'frame_token', 60);
            $setting->save();
            $task = new ScheduledTask();
            $task->userId = $user->id;
            $task->save();
            Notifications::pushNotifications($user->id, 'System', 'Your subscription will expire in ' . $user->subscription_end_date->format('Y M d') . '.');
            return redirect()->route('account.overview')->with('message', 'Account created successfully.');

        }
        return redirect()->route('account.overview')->with('error', 'Ops something wrong.');
    }

    public function updateProfile(ProfileUpdateRequest $request)
    {
        // dd($request->all());

        if ($request->file('img') != null) {

            $imageName = $request->file('img')->getClientOriginalName();
        }
        $user = Auth::user();
        $user->name = $request->name;
        if (User::whereEmail($request->email)->exists() && $request->email != $user->email) {
//            dd('can not');
            return back()->with('error', 'The email has already been taken');
        } else {
            $user->email = $request->email;
        }
        $user->job = $request->job;
        $user->city = $request->city;
        $user->address = $request->address;
        $user->description = $request->description;
        if ($request->file('img') != null) {
            $user->avatar = '/img/avatar/' . $imageName ?? $request->img;
        }
        $user->save();
        if ($request->file('img') != null) {
            $request->img->move(public_path('/img/avatar'), $imageName);
        }
        return redirect()->back()->with('message', 'Profile updated successfully.');
    }

    public function update($uId, Request $request)
    {
        $request->validate([
            'name' => 'required|max:78',
            // 'img' => 'image|mimes:jpeg,png,jpg|max:2048|nullable',
        ]);

        $user = $uId != Auth::id() ? User::findOrFail($uId) : Auth::user();

        if (User::whereEmail($request->email)->exists() && $request->email != $user->email) {
            return back()->with('error', 'The email has already been taken');
        }
//dd($request->all());
        $user->fill($request->only(['name', 'email', 'job', 'city', 'address', 'description', 'subscription_end_date']));
        if ($request->file('img')) {
            $imageName = $request->file('img')->getClientOriginalName();
            $user->avatar = '/img/avatar/' . $imageName;
            $request->img->move(public_path('/img/avatar'), $imageName);
        }

        $user->save();

        $this->updateRolesAndPermissions($user, $request->role, $request->permissions);

        return redirect()->back()->with('message', 'Updated successfully.');
    }

    protected function updateRolesAndPermissions(User $user, $selectedRoles, $selectedPermissions)
    {
        $roles = is_array($selectedRoles) ? $selectedRoles : [$selectedRoles];
        $permissions = is_array($selectedPermissions) ? $selectedPermissions : [$selectedPermissions];

        $user->roles()->sync(Role::whereIn('name', $roles)->pluck('id'));
        $user->permissions()->sync(Permission::whereIn('name', $permissions)->pluck('id'));
    }


    public function updateProfileSkills(Request $request)
    {
        $request->validate([
            'chips' => 'required',
        ]);
        $chips = $request->input('chips', []);

        foreach ($chips as $chip) {
            Skill::updateOrCreate([
                'name' => $chip,
                'userId' => Auth::id()
            ]);
        }
    }

    public function removeSkill($skillId)
    {
        $skill = Skill::find($skillId);
        if ($skill) {
            $skill->delete();

            return back()->with('message', 'Skill removed successfully');
        }

        return back()->with('message', 'Skill not found', 404);
    }


    public function createAccount(Request $request)
    {
        $request->validate([
            'name' => 'required|unique:users|regex:/^[^\s]+$/|max:78',
            'email' => 'required|email|unique:users|max:148',
//            'password' => 'required|confirmed|max:2048',
            'password' => ['required', 'confirmed', Rules\Password::defaults()],

            'img' => 'image|mimes:jpeg,png,jpg|max:2048|nullable',
        ],
            [
                'name.required' => 'The username field is required.',
                'name.unique' => 'The username has already been taken.',
                'name.regex' => 'The username must not contain spaces.',
            ]);

        //// Roles
        $selectedRoles = $request->role;
        $role = '';
// dd($request->all());
        if ($selectedRoles) {
            foreach ($selectedRoles as $roleName) {
                $role = Role::where('name', $roleName)->first();
            }
        }
        $imageName = null;
        if ($request->img !== null) {
            $imageName = $request->img->getClientOriginalName();
            $request->img->move(public_path('/img/avatar'), $imageName);
        }
        $user = new User();
        $user->subscription_end_date = now()->addMonths(1); // Set the end date to one month from now
        $user->name = $request->name;
        $user->email = $request->email;
        $user->password = bcrypt($request->password);
        $user->job = $request->job;
        $user->city = $request->city;
        $user->address = $request->address;
        $user->description = $request->description;
        $user->lang = $request->lang;
        if ($imageName !== null) {
            $user->avatar = '/img/avatar/' . $imageName;
        }
        if ($user->save()) {
            $user->assignRole(10);
            if ($role) {
                $user->assignRole($role);
            } else {
//                dd('no role');
                $user->assignRole('User');
            }

            $string = 'xSf1pvnMobVx15mjcCKS';
            $shuffled = str_shuffle($string);
            $setting = new Setting();
            $setting->userId = $user->id;
            $setting->api_token = $shuffled;
            $setting->frame_token = Setting::generateUniqueToken(Setting::class, 'frame_token', 60);
            $setting->save();
            $task = new ScheduledTask();
            $task->userId = $user->id;
            $task->save();
            Notifications::pushNotifications($user->id, 'System', 'Your subscription will expire in ' . $user->subscription_end_date->format('Y M d') . '.');
            if (Auth::id() == null) {
                event(new Registered($user));
                Auth::login($user);
                return redirect(RouteServiceProvider::HOME);
            }
        }
        return redirect()->route('dashboard')->with('success', 'Account created successfully.');
    }


    public function destroy($id, Request $request)
    {
//        $user = User::find($id);
//        if ($id != 20) {
//            $user->delete();
//            return back()
//                ->with('message', 'User deleted successfully');
//        }
        if ($request->id != null && $request->id != 20) {
            User::whereIn('id', $request->id)->delete();
            return back()->with('message', 'The Users has been deleted successfully');
        }

        $user = User::where('id', (int)$id != 20 ? $id : '');
        if ($user) {
            $user->delete();
            return back()->with('message', 'The User has been deleted successfully');
        }

        return back()->with('error', 'Ops something wrong');
    }

    public function groupDelete(Request $request)
    {
        if ($request->checkIfAllSelected) {
            $userIdsToDelete = User::whereIn('id', $request->id)->whereNot('id', Auth::id())
                ->pluck('id');
            if ($userIdsToDelete->count() > 0) {
//                DB::table('employers')->join('users','employers.user_id','users.id')
//                    ->select('users.*')->orderBy('users.id')->get();

                User::whereIn('id', $userIdsToDelete)->whereNot('id', Auth::id())->delete();

                Employer::whereIn('user_id', $userIdsToDelete)->delete();

                return back()->with('message', 'The Users have been deleted');
            }
        } else {

            $userIdsToDelete = !$request->checkIfAllSelected ? $request->uIds : [];
//            dd($request->all());

            if (count($userIdsToDelete) > 0) {
                User::whereIn('id', $userIdsToDelete)->delete();

                Employer::whereIn('user_id', $userIdsToDelete)->delete();

                return back()->with('message', 'The user(s) have been deleted');
            } else {
                return back()->with('error', 'No user selected');
            }
        }
        return back()->with('error', 'Ops something wrong');

    }


}
