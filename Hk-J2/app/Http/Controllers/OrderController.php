<?php

namespace App\Http\Controllers;

use App\Models\Event;
use App\Models\Order;
use App\Models\User;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    public function store(Request $request)
    {

        $request->validate([
            'name' => 'required|max:100',
            'email' => 'nullable|email|max:100',
            'phone' => 'required|Integer|max:15',
            'time' => '|date_format:H:i',
            'barber' => 'required',
            'service' => 'required|array|min:1',
        ]);
        $userId = User::getUserIdByToken($request->frameToken);
        $jS = json_encode($request->service);
        $strFirstO = str_replace('[','',$jS);
        $strSecO = str_replace(']','',$strFirstO);
//        dd($strSecO);
        $orders = Order::create(['employer_id' => $request->barber,
            'service_id' => $strSecO,
            'main_user_id' => $userId,
            'name' => $request->name,
            'email' => $request->email,
            'phone' => $request->phone,
            'date' => $request->date,
            'time' => $request->time,
            'price' => '0.99','status'=>'open']);
        if ($orders){
//         dd('nice');
            return back()->with('message', 'Successfully res');
        }
    }
    public function archive($rId)
    {

        if ($rId != null) {
            Order::find($rId)->delete();
            Event::where('res_id',$rId)->delete();
            return redirect()->route('dashboard')->with('message', 'The reservation has been archived successfully');
        }
        return redirect()->route('dashboard')->with('error', 'Ops something wrong');

    }
    public function destroy($rId)
    {

        if ($rId != null) {
            Order::find($rId)->forceDelete();
            Event::where('res_id',$rId)->forceDelete();
            return redirect()->route('dashboard')->with('message', 'The reservation has been deleted successfully');
        }
        return redirect()->route('dashboard')->with('error', 'Ops something wrong');

    }
}
