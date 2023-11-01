<?php

namespace App\Http\Controllers;

use App\Models\Order;
use App\Models\Setting;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class FrameController extends Controller
{
    public function index()
    {
        $schedule = Setting::getTheShopSchedule();
        $employers = User::getUserAllEmployers()->where('users.mark', 0 ) ->orWhere('users.mark',null)->paginate(10);
        $services = DB::table('services')->select('id','name','price')->where('userId',User::findTheMainUser()->id)->get();
        $markedEmployers = User::getUserAllEmployers()->where('users.mark', 1)->paginate(10);
        return inertia('Frame/Overview', ['employers' => $employers, 'markedEmployers' => $markedEmployers,'services' => $services, 'schedule' => $schedule,'frameToken' => User::getUserToken()]);
    }

    public function edit($token)
    {
//        if (Auth::check()) {
        $orders = Order::all();
        $disabledTimesByDay = [];

        foreach ($orders as $o){
            $disabledTimesByDay[] = $o->date;
            $disabledTimesByDay[] = $o->time;
        }
//        dd($disabledTimesByDay);
            if (User::verifyToken($token)) {
                $userId = User::getUserIdByToken($token);
                $schedule = Setting::getTheShopScheduleById($userId);
                $availableTimesByDay = [];
                foreach ($schedule as $s) {
                    if (isset($s['id'], $s['openingTime'], $s['closingTime'])) {
                        $openingTime = Carbon::createFromFormat('H:i', $s['openingTime']);
                        $closingTime = Carbon::createFromFormat('H:i', $s['closingTime']);

                        $times = [];
                        while ($openingTime->lessThan($closingTime)) {
                            $times[] = $openingTime->format('H:i');
                            $openingTime->addMinutes(Setting::getShopInterval($userId)->interval);
                        }

                        $dayId = $s['id'];
                        $availableTimesByDay[] = [
                            'dayId' => $dayId,
                            'times' => $times
                        ];
                    }
                }

                $services = DB::table('services')->select('id', 'name', 'price')->where('userId', Auth::id() ?? $userId)->get();
                $employers = User::getUserAllEmployers($userId)->where('users.mark', 1)->paginate(10);

                return inertia('Frame/View', ['employers' => $employers, 'services' => $services, 'schedule' => $schedule, 'availableTimesByDay' => $availableTimesByDay]);
            }
//        }
    }

    public function createServices(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'price' => 'required|numeric|min:0',
            'duration' => 'nullable|numeric|min:0',
        ]);
       $status = DB::table('services')
           ->insert(['userId' => User::findTheMainUser()->id,
           'name' => $request->name,
           'price' => $request->price,
           'duration' => $request->duration]);
          if ($status){
              return back()->with('message', 'Added successfully');
          }
        return back()->with('error', 'Ops something wrong');
    }
}
