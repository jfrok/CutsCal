<?php

namespace App\Http\Controllers;

use App\Models\Employer;
use App\Models\Notifications;
use App\Models\ScheduledTask;
use App\Models\Setting;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;
use Illuminate\Validation\Rules;

class EmployersController extends Controller
{
    function __construct()
    {
        $this->middleware('permission:employer-list|employer-create|employer-edit|employer-delete', ['only' => ['index']]);
        $this->middleware('permission:employer-create', ['only' => ['create', 'createEmployer']]);
        $this->middleware('permission:employer-edit', ['only' => ['edit', 'update']]);
        $this->middleware('permission:employer-delete', ['only' => ['destroy']]);
    }

    public function index()
    {
        $employers = User::getUserAllEmployers()->paginate(10);

        return inertia('Employers/Overview', ['employers' => $employers]);
    }

    public function create()
    {
        $allRoles = Role::where('userId', Auth::id())->pluck('name', 'name')->all();
        $allPermissions = Permission::orderBy('name', 'DESC')->whereNotIn('name', \App\Models\Role::preventedPermission())->pluck('name', 'name')->all();

        return inertia('Employers/Create', ['allRoles' => $allRoles, 'allPermissions' => $allPermissions]);
    }

    public function createEmployer(Request $request)
    {
        $request->validate([
            'name' => 'required|regex:/^[^\s]+$/|max:78',
            'email' => 'required|email|unique:users|max:148',
//            'password' => 'required|confirmed|max:2048',
            'password' => ['required', 'confirmed', Rules\Password::defaults()],

            'img' => 'image|mimes:jpeg,png,jpg|max:2048|nullable',
        ]);

        //// Roles
        if (isset($request->role)) {
            $selectedRoles = $request->role;
            foreach ($selectedRoles as $roleName) {
                $role = Role::where('name', $roleName)->first();
            }
        }
        $imageName = null;
        if ($request->img !== null) {
            $imageName = $request->img->getClientOriginalName();
            $request->img->move(public_path('/img/avatar'), $imageName);
        }
        $mainUser = User::findTheMainUser();
//        dd(Carbon::parse($mainUser->subscription_end_date)->format('Y-m-d'));
        $user = new User();
        /// the date of the main account owner
        $user->subscription_end_date = Carbon::parse($mainUser->subscription_end_date)->format('Y-m-d');
        $user->name = $request->name;
        $user->email = $request->email;
        $user->password = bcrypt($request->password);
        $user->job = $request->job;
        $user->city = $request->city;
        $user->address = $request->address;
        $user->description = $request->description;
        $user->lang = $mainUser->lang;
        if ($imageName !== null) {
            $user->avatar = '/img/avatar/' . $imageName;
        }
            $user->givePermissionTo([$request->permissions]) ?? '';
        if (isset($role)) {
            $user->assignRole($role);
        }
        if ($user->save()) {
            $employer = new Employer();
            $employer->belong_to = Auth::id();
            $employer->user_id = $user->id;
            $employer->save();
            $string = 'xSf1pvnMobVx15mjcCKS';
            $shuffled = str_shuffle($string);
            $setting = new Setting();
            $setting->userId = $user->id;
            $setting->api_token = $shuffled;
            $setting->save();
            $task = new ScheduledTask();
            $task->userId = $user->id;
            $task->save();
            return redirect()->route('employer.overview')->with('message', 'Employer created successfully.');
        }
//        dd($request->all());
        return back()->with('error', 'Ops something wrong!');

    }

    public function edit($eId)
    {
        $employer = User::findOrFail($eId);
        $roles = Role::where('userId', Auth::id())->pluck('name', 'name')->all();
        $employerRole = $employer->roles->pluck('name', 'name')->all();
        $allPermissions = Permission::orderBy('name', 'DESC')->pluck('name', 'name')->whereNotIn('name', \App\Models\Role::preventedPermission())->all();
        $addedPermissions = \App\Models\Role::getDirectPermission($eId);

        return inertia('Employers/Edit', ['employer' => $employer, 'employerRole' => $employerRole, 'allPermissions' => $allPermissions, 'addedPermissions' => $addedPermissions, 'roles' => $roles, 'userPermissions' => $employer->getAllPermissions()]);
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

        $user->fill($request->only(['name', 'email', 'job', 'city', 'address', 'description', 'subscription_end_date']));

        if ($request->file('img')) {
            $imageName = $request->file('img')->getClientOriginalName();
            $user->avatar = '/img/avatar/' . $imageName;
            $request->img->move(public_path('/img/avatar'), $imageName);
        }

        $user->save();

        $this->updateRolesAndPermissions($user, $request->role, $request->permissions);

        return back()->with('message', 'Updated successfully.');
    }

    protected function updateRolesAndPermissions(User $user, $selectedRoles, $selectedPermissions)
    {
        $roles = is_array($selectedRoles) ? $selectedRoles : [$selectedRoles];
        $permissions = is_array($selectedPermissions) ? $selectedPermissions : [$selectedPermissions];

        $user->roles()->sync(Role::whereIn('name', $roles)->pluck('id'));
        $user->permissions()->sync(Permission::whereIn('name', $permissions)->pluck('id'));
    }

    public function setMark(Request $request)
    {
        $selectedUserIds = $request->user_ids;
        User::whereIn('id', $selectedUserIds)->update(['mark' => 1]);
        // get main user ids or users all employers
        User::getUserAllEmployers()->get();
        $notSelected = User::getUserAllEmployers()
//            ->where('mark',1)
            ->pluck('id');
        $selectedUserIds == null ? User::whereIn('id', $notSelected)->update(['mark' => 0]) : User::whereNotIn('id', $selectedUserIds)->update(['mark' => 0]);

        return back()->with('message', 'Marks updated successfully.');
    }

    public function destroy($id)
    {
        $user = User::find($id);
        if ($id != 20) {
            $user->delete();
            return redirect()->route('employer.overview')
                ->with('message', 'Employer deleted successfully');
        }
    }
}
