<?php

namespace App\Console\Commands;

use App\Mail\ReminderEmail;
use App\Models\Event;
use App\Models\Notifications;
use App\Models\ScheduledTask;
use App\Models\Setting;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Mail;

class SendReminderEmail extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    // protected $signature = 'app:send-reminder-email';
    protected $signature = 'reminders:send';
    protected $description = 'Send email reminders for upcoming events.';

    /**
     * The console command description.
     *
     * @var string
     */
    /**
     * Execute the console command.
     */
    public function handle()
    {
        $events = Event::where('dateFrom', '>=', Carbon::now())
            ->get();
        // dd($events);

        foreach ($events as $event) {
            $user = User::find($event->userId);

            // Retrieve user settings dynamically
            $settings = Setting::where('userId', $user->id)->first();


            $sendBefore = $settings->sendBefore;
            // Check if settings exist for the user

            // Calculate the date to send reminder
            $reminderDate = Carbon::now()->addDays($sendBefore)->startOfDay();
            // Check if the event's date is after the reminder date
//            if ($settings->sendReminders === 1) {

            if (in_array('send-reminders', User::userAccess($event->userId))) {
                if ($event->dateFrom <= $reminderDate) {
                    // Send reminder email for this event
                    Mail::to($user->email)->send(new ReminderEmail($event));
                }
            }

        }
    }
}
