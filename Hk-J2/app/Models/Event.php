<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\Request;
use Carbon\Carbon;

class Event extends Model
{
    use HasFactory;

    /**
     * Static function to add a new event
     *
     * @param Request $request
     * @return Event
     */
    protected $fillable = [
        'userId',
        'title',
        'color',
        'description',
        'dateFrom',
        'dateTo',
        'timeFrom',
        'timeTo',
        'res_id',
    ];
    public static function addEvent(Request $request,$mainUserId)
    {
        // Validate the request data
        $request->validate([
            'title' => 'required|max:248',
            'color' => 'nullable|max:100',
            'description' => 'nullable|max:4999',
            'dateFrom' => 'date|required|max:48',
            'dateTo' => 'date|after:dateFrom|nullable|max:48',
        ], [
            'dateTo.after' => 'The dateTo must be after the dateFrom.',
        ]);

        // Create a new event
        $new = new self();
//        $new->userId = User::findTheMainUser()->id;
        $new->userId = $mainUserId;
        $new->title = $request->title;
        $new->color = $request->color;
        $new->description = $request->description;
        $new->dateFrom = $request->dateFrom;
        $new->dateTo = $request->dateTo;
        $new->timeFrom = $request->timeFrom;
        $new->res_id = $request->res_id;

        // Handle timeFrom and timeTo logic
        if (!is_null($request->timeFrom) && is_null($request->timeTo)) {
            $startTime = Carbon::parse($request->timeFrom)->format('H:i');
            $endTime = Carbon::parse($startTime)->addHour()->format('H:i');
            $request->merge(['timeTo' => $endTime]);
        } else {
            $request->merge(['timeTo' => $request->timeTo]);
        }

        $new->timeTo = $request->timeTo;
        $new->save();

        return $new;
    }
}
