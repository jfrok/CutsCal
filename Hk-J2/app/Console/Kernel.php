<?php

namespace App\Console;

use App\Jobs\SendReminderEmail;
use App\Models\Event;
use App\Models\Notifications;
use App\Models\ScheduledTask;
use Carbon\Carbon;
use Illuminate\Console\Scheduling\Schedule;
use Illuminate\Foundation\Console\Kernel as ConsoleKernel;
use Illuminate\Support\Facades\Auth;

class Kernel extends ConsoleKernel
{
    protected $commands = [
        '\App\Console\Commands\SendReminderEmail',
        '\App\Console\Commands\SendExpireReminder',
    ];

    /**
     * Define the application's command schedule.
     */
    protected function schedule(Schedule $schedule): void
    {
        $schedule->command('reminders:send')->dailyAt('07:00')->timezone('Europe/Amsterdam');
        $schedule->command('expireReminder:send')->twiceMonthly()->withoutOverlapping();
        $schedule->command('send-monthly-reminder:send')->dailyAt('07:00')->withoutOverlapping();
    }

    /**
     * Register the commands for the application.
     */
    protected function commands(): void
    {
        $this->load(__DIR__.'/Commands');

        require base_path('routes/console.php');
    }
}
