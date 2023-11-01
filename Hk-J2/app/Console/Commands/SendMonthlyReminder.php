<?php

namespace App\Console\Commands;

use App\Mail\MontlyReminder;
use App\Models\Event;
use App\Models\Setting;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\Mail;

class SendMonthlyReminder extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */

    protected $signature = 'send-monthly-reminder:send';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $today = Carbon::now();
        $monthLastDay = Carbon::parse($today)->endOfMonth()->toDateString();
        $eventsOfTheMonth = Event::whereMonth('dateFrom', $today);
        $users = User::all();
//        dd($monthLastDay);
        if ($today->format('Y-m-d') == $monthLastDay) {

            foreach ($users as $user) {
                $eventsForUser = $eventsOfTheMonth->where('userId', $user->id)->get();

//            dd($eventsForUser);
                Mail::to($user->email)->send(new MontlyReminder($eventsForUser));
            }
        }
    }

}
