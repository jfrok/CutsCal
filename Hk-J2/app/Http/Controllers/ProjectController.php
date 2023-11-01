<?php

namespace App\Http\Controllers;

use App\Models\Content;
use App\Models\Project;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class ProjectController extends Controller
{

    function __construct()
    {

        $this->middleware('permission:project-list|project-create|project-edit|project-delete', ['only' => ['index']]);
        $this->middleware('permission:project-create', ['only' => ['create','add']]);
        $this->middleware('permission:project-edit', ['only' => ['edit','update']]);
        $this->middleware('permission:project-delete', ['only' => ['destroy']]);
    }
    public function index()
    {
        $projects = Project::where('userId',Auth::id())->orderBy('created_at', 'DESC')->paginate(10);
        return \inertia('Projects/Overview', [
            'projects' => $projects
        ]);
    }
    public function create($uId)
    {
        if ($uId == Auth::id()){
            return \inertia('Projects/Add');
        }
        abort(404);
    }

    public function add(Request $request)
    {
        $request->validate([
            'title' => 'required|max:2048',
            'description' => 'required|max:6048',
            'demoUrl' => 'nullable|max:6048',
            'sourceUrl' => 'nullable|max:6048',
            'img' => 'file|max:2048',
        ]);
        $imageName = $request->file('img')->getClientOriginalName();
        // $image = $request->file('img')->store('cases','public');
        //  dd($image);
        $new = new Project();
        $new->userId = Auth::id();
        $new->title = $request->title;
        $new->description = $request->description;
        $new->sourceUrl = $request->sourceUrl;
        $new->demoUrl = $request->demoUrl;
        $new->path = '/img/cases/' . $imageName;
        $new->slug = $this->createSlug($request->title);
        $new->save();
        $request->img->move(public_path('/img/cases'), $imageName);

        return to_route('project.overview')->with('message', 'Successfully added');
    }
    public function createSlug($title, $id = 0)
    {
        $slug = str_replace(' ','-',$title);
        $allSlugs = $this->getRelatedSlugs($slug, $id);
        if (! $allSlugs->contains('slug', $slug)){
            return $slug;
        }

        $i = 1;
        $is_contain = true;
        do {
            $newSlug = $slug . '-' . $i;
            if (!$allSlugs->contains('slug', $newSlug)) {
                $is_contain = false;
                return $newSlug;
            }
            $i++;
        } while ($is_contain);
    }
    protected function getRelatedSlugs($slug, $id = 0)
    {
        return Project::select('slug')->where('slug', 'like', $slug.'%')->where('userId',Auth::id())
            ->where('id', '<>', $id)
            ->get();
    }

    public function destroy(Request $request,$pId)
    {
        Project::find($pId)->delete();
        Content::where('project_id',$pId)->delete();
    }
}
