<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;

class Setting extends Model
{
    use HasFactory;

    public static function getTheShopSchedule()
    {
        $scheduledTask = DB::table('scheduled_tasks')->where('userId',User::findTheMainUser()->id ?? '')->first();
        $unScheduledTask = unserialize($scheduledTask->days_times ?? '');
        if ($unScheduledTask){
            return $unScheduledTask;
        }
    }
    public static function getTheShopScheduleById($id)
    {
        $scheduledTask = DB::table('scheduled_tasks')->where('userId',$id)->first();
        $unScheduledTask = unserialize($scheduledTask->days_times ?? '');
        if ($unScheduledTask){
            return $unScheduledTask;
        }
    }
    public static function getShopInterval($id = null)
    {
       $userInterval = DB::table('scheduled_tasks')->select('interval')
            ->where('userId',User::findTheMainUser()->id ?? $id)->first();
       if ($userInterval){
           return $userInterval;
       }
    }
    public static function generateUniqueToken($model,$col,$length = 32) {
        do {
            $token = \Illuminate\Support\Str::random($length);
        } while ($model::where($col, $token)->exists());

        return $token;
    }
}
