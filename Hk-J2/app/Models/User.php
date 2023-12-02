<?php

namespace App\Models;

// use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Laravel\Sanctum\HasApiTokens;
use Spatie\Permission\Traits\HasRoles;

class User extends Authenticatable
{
    use HasApiTokens, HasFactory, Notifiable, HasRoles;

    /**
     * The attributes that are mass assignable.
     *
     * @var array<int, string>
     */
    protected $fillable = ['name', 'email', 'job', 'city', 'address', 'description', 'subscription_end_date', 'img'];


    /**
     * The attributes that should be hidden for serialization.
     *
     * @var array<int, string>
     */
    protected $hidden = [
        'password',
        'remember_token',
    ];

    /**
     * The attributes that should be cast.
     *
     * @var array<string, string>
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public function skills()
    {
        return $this->hasMany(Skill::class, 'userId');
    }

    public function subscription()
    {
        return $this->hasOne(Subscription::class, 'userId');
    }

    public function userId()
    {
        return $this->id;
    }

    static function userAccess($id)
    {
        $user = User::find($id);
        if ($user) {
            $rolePermissions = [];
            foreach ($user->getAllPermissions() as $role) {
                $permissions = $role->name;
                $rolePermissions[] = $permissions;
            }

            return $rolePermissions;
        }
        return redirect()->route('login');
    }

    static function findTheMainUser()
    {
        $findTheMainUser = Employer::where('user_id', Auth::id())->first();

        if ($findTheMainUser) {
            $userIdToQuery = $findTheMainUser->belong_to ?? Auth::id();
            return User::find($userIdToQuery);
        } else {
            $userIdToQuery = Auth::id();
            return User::find($userIdToQuery);
        }
    }

    public static function getTheUserSchedule()
    {
        $scheduledTask = DB::table('employer_schedules')->where('userId', Auth::id())->first();
        $unScheduledTask = unserialize($scheduledTask->days_times ?? '');
        if ($unScheduledTask) {
            return $unScheduledTask;
        }
    }

    static function getUserAllEmployers($id = null)
    {
        $employers = DB::table('employers')
            ->join('users', 'employers.user_id', '=', 'users.id')
            ->select('users.id','users.name','users.email','users.job','users.city','users.address','users.description','users.avatar','users.created_at')
            ->where('belong_to', User::findTheMainUser()->id ?? $id)
            ->orderBy('users.created_at');
        if ($employers) {
            return $employers;
        }
    }
    static function getUserToken($userId = null) {
        $token = Setting::where('userId', User::findTheMainUser()->id ?? $userId)
            ->pluck('frame_token');

        return $token;
    }

    public static function getUserIdByToken($token) {
        $user_id = DB::table('settings')
            ->where('frame_token', $token)
            ->value('userId');
        return $user_id;
    }
    static function verifyToken($token) {
        $exists = Setting::where('frame_token', $token)
            ->exists();

        return $exists;
    }
    public static function getMainUserOrders()
    {
        $orders = DB::table('orders')
            ->join('users', 'orders.employer_id', '=', 'users.id')
            ->select('orders.email', 'users.name as user_name', 'orders.email',
                'orders.name', 'orders.service_id', 'orders.phone',
                'orders.date', 'orders.time', 'orders.price', 'status', 'orders.created_at', 'orders.id as order_id')
            ->where('orders.main_user_id', self::findTheMainUser()->id ?? '')
            ->orderBy('orders.created_at', 'DESC');
        if ($orders) {
            return $orders;
        }
    }

    public static function getUserServicesById($id = null)
    {
        $services = DB::table('services')->select('services.*')->where('userId', self::findTheMainUser()->id ?? '')->whereIn('id', $id);
//        dd($services) ;
        return $services;
    }

    public static function ordersFormated()
    {
        $orders = self::getMainUserOrders()->get();
        $arr = [];
        foreach ($orders as $order) {
            $arr[] = [
                'order_id' => $order->order_id,
                'name' => $order->name,
                'user_name' => $order->user_name,
                'email' => $order->email,
                'phone' => $order->phone,
                'date' => $order->date,
                'time' => $order->time,
                'price' => $order->price,
                'service' => self::getUserServicesById(explode(',', $order->service_id))->get(),
                'created_at' => $order->created_at];
        }
        return $arr;
    }
//    public function belongRoles()
//    {
//        return $this->hasMany(Role::class, 'userId');
//    }
}
