<?php

namespace App\Http\Controllers;

use App\Models\Content;
use App\Models\Project;
use App\Models\Setting;
use App\Models\User;
use Illuminate\Support\Facades\Auth;

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
}
