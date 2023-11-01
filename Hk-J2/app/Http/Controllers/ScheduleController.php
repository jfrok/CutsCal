<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ScheduleController extends Controller
{
    public function store(Request $request)
    {
        $interval = $request->interval;
        $receivedDays = $request->days;
            $dayId = serialize($receivedDays);
            $request->validate([
                'interval' => 'required|numeric|max:60'
            ]);
            DB::table('scheduled_tasks')->where('userId',User::findTheMainUser()->id)->update(
                [
                    'interval' => $interval,
                    'days_times' => $dayId,
                ]
            );
        return redirect()->back()->with('message', 'Schedule Task added successfully!');
    }
    public function storeEmployerSchedule(Request $request)
    {
//        dd($request->days);
        $receivedDays = $request->days;
        $dayId = serialize($receivedDays);

        foreach ($receivedDays as $day) {
            if (strtotime($day['closingTime']) <= strtotime($day['openingTime'])) {
                return redirect()->back()->with('error', 'Closing time cannot be earlier than or equal to opening time.');
            }
        }
        $schedule = DB::table('employer_schedules')->where('userId',Auth::id());
       $schedule->exists() ?
            $schedule->update(
            ['days_times' => $dayId,])
     :
            $schedule->insert(
                ['userId' => Auth::id(),
                'days_times' => $dayId,]
            );

        return redirect()->back()->with('message', 'Schedule Task added successfully!');
    }
}
