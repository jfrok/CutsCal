<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;

class Notifications extends Model
{
    use HasFactory;
    static function pushNotifications($userId,$title,$message){
       $new = new Notifications();
        $new->title = $title;
        $new->message = $message;
        $new->userId = $userId;
        $new->sendedBy = 20;
        $new->save();
    }
}
