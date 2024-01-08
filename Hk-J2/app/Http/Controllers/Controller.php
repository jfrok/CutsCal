<?php

namespace App\Http\Controllers;

use App\Models\Client;
use App\Models\Content;
use App\Models\Event;
use App\Models\Project;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Foundation\Auth\Access\AuthorizesRequests;
use Illuminate\Foundation\Validation\ValidatesRequests;
use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class Controller extends BaseController
{
//    function __construct()
//    {
//        $this->middleware('permission:trash-list|trash-restore|trash-force-delete', ['only' => ['trash']]);
//        $this->middleware('permission:trash-restore', ['only' => ['restore']]);
//        $this->middleware('permission:trash-force-delete', ['only' => ['forceDelete']]);
//    }
    public function dashboard(Request $request)
    {
        $mainUserId = User::findTheMainUser()->id;

        $clients = Client::where('userId', $mainUserId)->orderBy('created_at', 'DESC')->paginate(10);
        $projects = Project::where('userId', $mainUserId)->orderBy('created_at', 'DESC')->paginate(10);
        $notes = DB::table('notes')->where('userId', $mainUserId)->get();
        $orders = User::ordersFormated();//User::getMainUserOrders()->paginate(20);

        $filter = $request->filter;

        $startOfWeek = Carbon::now()->startOfWeek(Carbon::MONDAY);
        $endOfWeek = Carbon::now()->endOfWeek(Carbon::SUNDAY);
        $thisWeek = [
            'start' => $startOfWeek->format('Y-m-d'),
            'end' => $endOfWeek->format('Y-m-d'),
        ];

        $showMore = $request->showMore;

        //past keep it in mind
        $countNextEvent = Event::where('userId', $mainUserId)
            ->when($filter == 'past', function ($query) {
                return $query->where('dateFrom', '<', Carbon::now());

            })
            ->when(!$filter, function ($query) {
                return $query->where('dateFrom', '>', Carbon::now());

            })
            ->when($filter == 'upcoming', function ($query) {
                return $query->where('dateFrom', '>=', Carbon::now()->addWeek()->format('Y-m-d'));
            })
            ->when($filter == 'closest', function ($query) use ($thisWeek) {
                return $query->where(function ($query) use ($thisWeek) {
                    $query->whereBetween('dateFrom', [$thisWeek['start'], $thisWeek['end']]);
                });
            })
            ->skip($showMore ? $showMore : 10)->take($showMore ? $showMore : 10)->get()->count();

//        $eventCounter = count(Event::where('userId',Auth::id())->where('dateFrom','>=',Carbon::now())->get());

        $events = Event::orderBy('dateFrom', 'DESC')
            ->where('userId', $mainUserId)
            ->when(!$filter, function ($query) {
                return $query->where('dateFrom', '>=', Carbon::now()->format('Y-m-d'));
            })
            ->when($filter == 'past', function ($query) {
                return $query->where('dateFrom', '<', Carbon::now()->format('Y-m-d'));
            })
            ->when($filter == 'upcoming', function ($query) {
                return $query->where('dateFrom', '>=', Carbon::now()->addWeek()->format('Y-m-d'));
            })
            ->when($filter == 'closest', function ($query) use ($thisWeek) {
                return $query->where(function ($query) use ($thisWeek) {
                    $query->whereBetween('dateFrom', [$thisWeek['start'], $thisWeek['end']]);
                });
            })
            ->take($showMore ? $showMore : 10)->get();


        $counterTrueOrFalse = 0;


        if ($showMore >= $countNextEvent) {
            //dd('yes reached max');
            $counterTrueOrFalse = 1;
        }
//        dd(count(Event::where('userId',Auth::id())->skip($showMore ? $showMore : 10)->take($showMore ? $showMore : 10)->get()));
        $totalUsers = User::all()->count();
        /// manin user userId
        $totalClients = Client::where('userId', $mainUserId)->count();
        /// manin user userId
        $totalEvents = Event::where('userId', $mainUserId)->where('dateFrom', '>=', Carbon::now())->count();
        /// manin user userId
        $totalProjects = Project::where('userId', $mainUserId)->count();
//        dd(Auth::user()->created_at->format('Y-m-d') ?? '');
        $period = \Carbon\CarbonPeriod::create(Carbon::today() ?? '2023-05-25', Carbon::today()->addMonths(1));


//        $p = [];
//        $count = [];
//        $eventCount = [];
//
//        foreach ($period as $date) {
//            $p[] = Carbon::parse($date)->format('M');
//        }
//
//        foreach ($p as $pd) {
//            $projectCount = Project::where('userId', $mainUserId)
//                ->whereDate('created_at', Carbon::parse($pd))
//                ->count();
//
//            $count[] = $projectCount > 0 || !Carbon::parse($pd)->isFuture() ? $projectCount : 0;
//        }
//
//        foreach ($p as $pd) {
//            $eventCount[] = Event::where('userId', $mainUserId)
//                ->whereDate('dateFrom', Carbon::parse($pd))
//                ->count();
//        }


        $currentYear = Carbon::now()->year;
        $currentMonth = Carbon::now()->month;
        $clientCount = [];
        $monthsInYear = Carbon::createFromDate($currentYear, 1, 1)->monthsUntil(Carbon::createFromDate($currentYear, 12, 31));

        foreach ($monthsInYear as $month) {
            $p[] = $month->format('M');
        }

        foreach ($p as $pd) {
            $projectCount = Project::where('userId', $mainUserId)
                ->whereMonth('created_at', Carbon::parse($pd)->month)
                ->count();

            $count[] = $projectCount > 0 || !Carbon::parse($pd)->isFuture() ? $projectCount : 0;

            // Filter events for the current month and year
            $eventCount[] = Event::where('userId', $mainUserId)
                ->whereYear('dateFrom', $currentYear)
                ->whereMonth('dateFrom', Carbon::parse($pd)->month)
                ->count();
            $clientCount[] = Client::where('userId', $mainUserId)
                ->whereYear('created_at', $currentYear)
                ->whereMonth('created_at', Carbon::parse($pd)->month)
                ->count();
        }
        return inertia('Dashboard', [
            'p' => $p,
            'countNextEvent' => $countNextEvent,
            'counterTrueOrFalse' => $counterTrueOrFalse,
            'count' => $count,
            'clientCount' => $clientCount,
            'eventCount' => $eventCount,
            'clients' => $clients,
            'projects' => $projects,
            'events' => $events,
            'notes' => $notes,
            'orders' => $orders,
            'totalUsers' => $totalUsers,
            'totalEvents' => $totalEvents,
            'totalProjects' => $totalProjects,

        ]);
    }

    use AuthorizesRequests, ValidatesRequests;

    public function makeNote(Request $request)
    {
//        dd($request->all());
        $request->validate([
            'note' => 'required|string|max:250',
            'color' => 'nullable|string|max:250',
        ]);

        $new = DB::table('notes')->insert([
            'notes' => $request->note,
            'userId' => Auth::id(),
            'color' => $request->color,
        ]);
        if ($new) {
            return back()->with('message', 'The note added successfully');
        }
        return back()->with('error', 'Ops something wrong');

    }

    public function removeNote($nId)
    {
        $selectedNote = DB::table('notes')->where('id', $nId);
        if ($selectedNote->delete()) {
            return back()->with('success', 'The note deleted successfully');
        }
        return back()->with('error', 'Ops something wrong');
    }

    public function trash()
    {
        $trashed = Project::onlyTrashed()->where('userId', User::findTheMainUser()->id)->get();
        return inertia('Trash', [
            'trashed' => $trashed
        ]);
    }

    public function forceDelete($pId)
    {
        $project = Project::onlyTrashed()->find($pId);
        $content = Content::onlyTrashed()->where('project_id', $pId);
        if ($project == true) {
            $project->forceDelete();
            $content->forceDelete();
        }
        return back()->with('error', 'The project has been permanently deleted');
    }

    public function restore($pId)
    {
        $project = Project::onlyTrashed()->find($pId);
        $content = Content::onlyTrashed()->where('project_id', $pId);
        if ($project == true) {
            $project->restore();
            $content->restore();
        }
        return back()->with('warning', 'The project has been restored');
    }

    public function groupDelete(Request $request)
    {
        // dd($request->all());
        if ($request->checkIfAllSelected === true) {
            $allProjectSelected = Project::onlyTrashed();
            // dd($allContentSelected);
            if ($allProjectSelected->count() > 0) {
                $allProjectSelected->forceDelete();
                return back()->with('error', 'The content has been permanently deleted');
            }
        }
        $projects = Project::onlyTrashed()->whereIn('id', $request->checkIfAllSelected == false ? $request->pIds : '');
        $contents = Content::withTrashed()->whereIn('project_id', $request->checkIfAllSelected == false ? $request->pIds : '');
        if ($projects->count() > 0) {
            $projects->forceDelete();
            if ($contents->count() > 0) {
                $contents->forceDelete();
            }
            return back()->with('error', 'The content has been permanently deleted');
        } else {
            return back()->with('error', 'No content selected');

        }
    }

    public function PrivacyPolicy()
    {
        return \inertia('Privacy_policy');
    }

}
