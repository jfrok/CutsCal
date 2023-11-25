<?php

namespace App\Http\Controllers;

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
}
