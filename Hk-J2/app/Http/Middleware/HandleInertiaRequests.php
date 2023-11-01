<?php

namespace App\Http\Middleware;

use App\Models\Notifications;
use App\Models\Setting;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Inertia\Middleware;
use Tightenco\Ziggy\Ziggy;

class HandleInertiaRequests extends Middleware
{
    /**
     * The root template that is loaded on the first page visit.
     *
     * @var string
     */
    protected $rootView = 'app';

    /**
     * Determine the current asset version.
     */
    public function version(Request $request): string|null
    {
        return parent::version($request);
    }

    /**
     * Define the props that are shared by default.
     *
     * @return array<string, mixed>
     */
    public function share(Request $request): array
    {
        return array_merge(parent::share($request), [
            'auth' => [
                'user' => $request->user(),
                'userRole' => User::userAccess(Auth::id()),
                'schedule' => Setting::getTheShopSchedule(),
                'interval' => Setting::getShopInterval(),
                'notifications' => Notifications::where('userId',Auth::id())->get()
            ],
            'ziggy' => function () use ($request) {
                return array_merge((new Ziggy)->toArray(), [
                    'location' => $request->url(),
                    'flash' => [
                        'message' => session('message'),
                        'warning' => session('warning'),
                        'error' => session('error')
                    ]
                ]);
            },
        ]);
    }
}
