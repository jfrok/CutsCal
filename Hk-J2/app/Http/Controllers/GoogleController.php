<?php

namespace App\Http\Controllers;

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
        if (!$user){
        $user = User::updateOrCreate(
            ['name' => $user->getName()],
            ['email' => $user->getEmail()],
            ['google_id' => $user->getId()]
        );

        Auth::login($user, true);

        return redirect()->intended('dashboard');
        }
        } catch (\Exception $e) {
            return redirect('auth/google');
        }
    }

}
