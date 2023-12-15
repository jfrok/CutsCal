<?php

namespace App\Http\Controllers;

use App\Models\Content;
use App\Models\Order;
use App\Models\Project;
use App\Models\Setting;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\DB;


class ApiController extends Controller
{
    public function projects($token)
    {
        $setting = Setting::where('api_token', $token)->first();
        $check = Setting::where('api_token', $token)->first();
        if ($setting) {
            $project = Project::where('userId',$check->userId)
                ->select(['id', 'title', 'description','path','slug','sourceUrl','demoUrl','created_at','updated_at'])
                ->get();
          return response()->json(['projects' => $project]);
        } else {
            return response()->json(['error' => 'Invalid token'], 401);
        }
    }

    public function content($slug, $token)
    {
        $setting = Setting::where('api_token', $token)->first();
        $check = Setting::where('api_token', $token)->first();
        if ($setting) {
            $content = Content::select('contents.*')
                ->join('projects', 'contents.project_id', '=', 'projects.id')
                ->where('projects.slug', $slug)
                ->where('projects.userId',$check->userId)
                ->orderBy('sort')->get()->toArray();
            return response()->json(['content' => $content]);
        } else {
            return response()->json(['error' => 'Invalid token'], 401);
        }
    }

    public function personalDetails($token)
    {
        $setting = Setting::where('api_token', $token)->first();
        $check = Setting::where('api_token', $token)->first();

        if ($setting) {
            $user = User::find($check->userId);
            $userDetails = $user->only(['name', 'email', 'city', 'address', 'job', 'description']);
            $skills = $user->skills->pluck('name');

            return response()->json([
                'personalDetails' => [
                    'user' => $userDetails,
                    'skills' => $skills
                ]
            ]);
        } else {
            return response()->json(['error' => 'Invalid token'], 401);
        }
    }

    // Frame Reservation template
    public function reservationData($token)
    {

        if (User::verifyToken($token)) {

            $userId = User::getUserIdByToken($token);
//            dd($userId);

            $orders = Order::where('main_user_id', $userId)->get();

            // Extract the existing disabled times from orders
            $disabledTimesByDay = [];
            foreach ($orders as $o) {
                $disabledTimesByDay[] = $o->date;
                $disabledTimesByDay[] = $o->time;
            }

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
                        'times' => $times,
                    ];
                }
            }

            $services = DB::table('services')->select('id', 'name', 'price')->where('userId', Auth::id() ?? $userId)->get();
            $employers = User::getUserAllEmployers($userId)->where('users.mark', 1)->paginate(10);

            $responseData = [
                'employers' => $employers,
                'orders' => $orders,
                'services' => $services,
                'schedule' => $schedule,
                'availableTimesByDay' => $availableTimesByDay,
                'disabledTimesByDay' => $disabledTimesByDay,
            ];

            return response()->json($responseData, JsonResponse::HTTP_OK);
        }

        return response()->json(['error' => 'Invalid token'], JsonResponse::HTTP_UNAUTHORIZED);
    }
    public function storeReservation(Request $request)
    {
        dd('hoi');
        $request->validate([
            'name' => 'required|max:100',
            'email' => 'nullable|email|max:100',
            'phone' => 'required|Integer|max:15',
            'time' => 'date_format:H:i',
            'barber' => 'required',
            'service' => 'required|array|min:1',
        ]);

        $userId = User::getUserIdByToken($request->frameToken);

        $jS = json_encode($request->service);
        $strFirstO = str_replace('[','',$jS);
        $strSecO = str_replace(']','',$strFirstO);

        $orders = Order::create([
            'employer_id' => $request->barber,
            'service_id' => $strSecO,
            'main_user_id' => $userId,
            'name' => $request->name,
            'email' => $request->email,
            'phone' => $request->phone,
            'date' => $request->date,
            'time' => $request->time,
            'price' => '0.99',
            'status' => 'open'
        ]);

        if ($orders) {
            return response()->json(['message' => 'Successfully reserved'], 200);
        } else {
            return response()->json(['error' => 'Failed to reserve'], 500);
        }
    }

}
