<?php

namespace App\Http\Controllers;

use App\Models\Employer;
use App\Models\Event;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class EventController extends Controller
{
    function __construct()
    {
        $this->middleware('permission:event-calendar|event-list|event-create|event-edit|event-delete', ['only' => ['index']]);
        $this->middleware('permission:event-create', ['only' => ['add']]);
        $this->middleware('permission:event-edit', ['only' => ['update']]);
        $this->middleware('permission:event-delete', ['only' => ['remove']]);
    }
    public function index(Request $request)
    {
        $findTheMainUser = Employer::where('user_id', Auth::id())->first();

        if ($findTheMainUser) {
            $userIdToQuery = $findTheMainUser->belong_to ?? Auth::id();
        } else {
            $userIdToQuery = Auth::id();
        }

        $events = Event::where('userId', $userIdToQuery)->get();
        $date = $request->input('date');

        return inertia('Calendar/Overview',  [
            'date' => $date,
            'events' => $events->map(function ($event) {
                return [
                    'id' => $event->id,
                    'title' => $event->title,
                    'dateFrom' => $event->dateFrom,
                    'dateTo' => $event->dateTo,
                ];
            })
        ]);
    }

    public function add(Request $request)
    {
//        dd($request->all());
        $request->validate([
            'title' => 'required|max:248',
            'color' => 'nullable|max:100',
            'description' => 'nullable|max:4999',
            'dateFrom' => 'date|required|max:48',
            'dateTo' => 'date|after:dateFrom|nullable|max:48',
        ], [
            'dateTo.after' => 'The dateTo must be after the dateFrom.',
        ]);

        $new = new Event();
        $new->userId = User::findTheMainUser()->id;
        $new->title = $request->title;
        $new->color = $request->color;
        $new->description = $request->description;
        $new->dateFrom = $request->dateFrom;
        $new->dateTo = $request->dateTo;
        $new->timeFrom = $request->timeFrom;
        if (!is_null($request->timeFrom) && is_null($request->timeTo)) {
            $startTime = \Carbon\Carbon::parse($request->timeFrom)->format('H:i');
            $endTime = \Carbon\Carbon::parse($startTime)->addHour()->format('H:i');
            $request->merge(['timeTo' => $endTime]);
        } else {
            $request->merge(['timeTo' => $request->timeTo]);
        }
        $new->timeTo = $request->timeTo;
        $new->save();
        return to_route('calendar.overview');
    }
    public function update($eId,Request $request)
    {
//        dd($request->all());
        $request->validate([
            'title' => 'required|max:248',
            'description' => 'nullable|max:4999',
            'color' => 'nullable|max:100',
            'dateFrom' => 'date|required|max:48',
//            'dateTo' => 'date|after:dateFrom|nullable|max:48',
        ], [
            'dateTo.after' => 'The dateTo must be after the dateFrom.',
        ]);
//        dd($request->all());
        $update = Event::find($eId);
        $update->description = $request->description;
        $update->title = $request->title;
        $update->color = $request->color;
        $update->dateFrom = $request->dateFrom;
       $request->dateTo == 'Invalid date' ? $update->dateTo = null : $update->dateTo = $request->dateTo;

        $update->timeFrom = $request->timeFrom;
        if (!is_null($request->timeFrom) && is_null($request->timeTo)) {
            $startTime = \Carbon\Carbon::parse($request->timeFrom)->format('H:i');
            $endTime = \Carbon\Carbon::parse($startTime)->addHour()->format('H:i');
            $request->merge(['timeTo' => $endTime]);
        } else {
            $request->merge(['timeTo' => $request->timeTo]);
        }
        $update->timeTo = $request->timeTo;
        $update->save();
        return to_route('calendar.overview');
    }
    public function remove($eId)
    {
        Event::find($eId)->delete();
    }
    public function getEvents()
    {

        // Get the main user's events
        $mainUserEvents = Event::where('userId', User::findTheMainUser()->id)->get();

//        // Get users who have employers
//        $usersWithEmployers = Employer::where('user_id', Auth::id())->pluck('user_id')->all();
//
//        // Get events for users who have employers
//        $employerEvents = Event::whereIn('userId', $usersWithEmployers)->get();

        // Merge the two event collections
//        $mergedEvents = $mainUserEvents->concat($employerEvents);

//            Event::where('userId',$userIdToQuery)->orWhere('userId',Auth::id())->get();

        return response()->json(['events' => $mainUserEvents]);
    }

}
