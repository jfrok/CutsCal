<?php

namespace App\Http\Controllers;

use App\Models\Notifications;
use App\Models\ScheduledTask;
use App\Models\Setting;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Laravel\Socialite\Facades\Socialite;

header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET, POST, OPTIONS");
header("Access-Control-Allow-Headers: Origin, Content-Type, Accept, Authorization, X-Requested-With");

class GoogleController extends Controller
{
    public function redirectToGoogle()
    {
        return Socialite::driver('google')->redirect();
    }

    public function handleGoogleCallback()
    {
        try {
            $google_user = Socialite::driver('google')->user();
            $user = User::where('google_id', $google_user->getId())->first();
            if (!$user) {
                $user = new User();
                $user->name = $google_user->getName();
                $user->email = $google_user->getEmail();
                $user->subscription_end_date = now()->addMonths(1);
                $user->google_id = $google_user->getId();
                if ($user->save()) {
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
                    $user->assignRole(10);
                }
            }
            if($user){
                Auth::login($user, true);
                return redirect()->intended('dashboard');
            }
        } catch (\Exception $e) {
            return redirect('auth/google');
        }
    }

}
