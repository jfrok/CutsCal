<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Support\Facades\Auth;

class CheckSubscription
{
    public function handle($request, Closure $next)
    {
//        if (Auth::user()->role == 'Admin') {
        if (Auth::check() && Auth::user()->subscription_end_date < now()) {
            Auth::logout();
            return redirect()->route('login')->with('error', 'Your subscription has ended. Please renew your subscription to continue.');
        }
//        }
        return $next($request);
    }
}
