<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    use HasFactory;

    protected $fillable = ['main_user_id','employer_id', 'service_id', 'name', 'email', 'phone', 'date', 'time','price'];
}
