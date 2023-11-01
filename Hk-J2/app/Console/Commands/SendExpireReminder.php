<?php

namespace App\Console\Commands;

use App\Models\Notifications;
use App\Models\ScheduledTask;
use Carbon\Carbon;
use Illuminate\Console\Command;

class SendExpireReminder extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'expireReminder:send';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     */
    public function handle(): void
    {
        $scheduledTasks = ScheduledTask::all(); // Retrieve all scheduled task records

        foreach ($scheduledTasks as $scheduledTask) {
            $subscriptionEndDate = $scheduledTask->user->subscription_end_date;
            $daysDifference = Carbon::now()->diffInDays($subscriptionEndDate, false);

            if ($daysDifference <= 31) {
                Notifications::pushNotifications($scheduledTask->user->id, 'System', 'Your subscription will expire on ' . $subscriptionEndDate . '.');
            }
        }
    }
}
