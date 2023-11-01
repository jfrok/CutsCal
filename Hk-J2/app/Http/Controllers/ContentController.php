<?php

namespace App\Http\Controllers;

use App\Models\Content;
use App\Models\Project;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\Console\Input\Input;

class ContentController extends Controller
{
    function __construct()
    {
        $this->middleware('permission:content-list|content-create|content-edit|content-delete', ['only' => ['index']]);
        $this->middleware('permission:content-create', ['only' => ['create','add','addFoto','storeFoto']]);
        $this->middleware('permission:content-edit', ['only' => ['edit','save','editSort']]);
        $this->middleware('permission:content-delete', ['only' => ['destroy']]);
    }
    public function index($pId)
    {
        $project = Project::withTrashed()->where('id', $pId)->where('userId',Auth::id())->first();
        if ($project){
        $contents = Content::withTrashed()->where('project_id', $pId)->orderBy('sort')->get();

        return inertia('Content/Overview', [
            'show' => $project,
            'contents' => $contents->map(function ($content) {
                return [
                    'id' => $content->id,
                    'title' => $content->title,
                    'description' => $content->description,
                    'path' => $content->foto,
                    'type' => $content->type,
                ];
            })
        ]);
        }else{
            abort(404);
        }

    }

    public function add($pId)
    {
        $project = Project::withTrashed()->where('id', $pId)->first();
        return inertia('Content/Add', [
            'pId' => $project,

        ]);
    }

    public function addFoto($pId)
    {

        $project = Project::withTrashed()->where('id', $pId)->first();
        return inertia('Content/AddFoto', [
            'pId' => $project,

        ]);
    }

    public function storeFoto(Request $req)
    {
      //  dd($req->all());

        $image = $req->file('img');
        $allFile = count($req->file('img'));

        if($image) {
            for ($i = 0; $i < $allFile; $i++) {
               // dd($image[$i]);
              $imageName =  $image[$i]->getClientOriginalName();
                $inset = new Content();
                $inset->project_id = $req->project_id;
                $inset->foto = $imageName;
                $inset->type = 'Foto';
                $inset->save();
                $image[$i]->move(public_path('/img/cases'), $imageName);
            }
        }

        return redirect(route('content.index', $req->project_id))->with('message', 'Image added successfully');
    }

    public function create(Request $request, $pId)
    {
        $request->validate([
            'title' => '|max:2048',
            'description' => 'required|max:6048',
        ]);
        $new = new Content();
        $new->project_id = $pId;
        if ($request->title != null) {
            $new->title = $request->title;
            $new->description = $request->description;
            $new->type = 'Text';
        }
        $new->foto = $request->foto;

        $new->sort = $request->sort;
        $new->save();
        return redirect(route('content.index', $pId))->with('message', 'Text added successfully');
    }

//    public function edit($cId)
//    {
//        $slectedContent = Content::find($cId);
//        return response()->json([
//            'slectedContent' => $slectedContent
//        ]);
//    }
    public function edit($cId)
    {
        $slectedContent = Content::withTrashed()->find($cId);
        return inertia('Content/Edit', [
            'slectedContent' => $slectedContent
        ]);
    }

    public function save(Request $request, $cId)
    {
        $slectedContent = Content::withTrashed()->find($cId);
        $slectedContent->title = $request->title;
        $slectedContent->description = $request->description;
        $slectedContent->save();
        //  $slectedContent = Content::find($cId);
        return to_route('content.index', $slectedContent->project_id)->with('message', 'Successfully edited');
    }

    public function destroy($cId)
    {
        $content = Content::withTrashed()->find($cId);
        $content->forceDelete();
        return back()->with('error', 'The content has been permanently deleted');
    }

    public function groupDelete(Request $request)
    {
        // dd($request->all());
        if ($request->checkIfAllSelected === true) {
            $allContentSelected = Content::withTrashed()->where('project_id', $request->pId);
            // dd($allContentSelected);
            if ($allContentSelected->count() > 0) {
                $allContentSelected->forceDelete();
                return back()->with('error', 'The content has been permanently deleted');
            }
        }
        $content = Content::withTrashed()->whereIn('id', $request->checkIfAllSelected == false ? $request->selectedContentIds : '');
        if ($content->count() > 0) {
            $content->forceDelete();
            return back()->with('error', 'The content has been permanently deleted');
        } else {
            return back()->with('error', 'No content selected');

        }
    }

    public function editSort()
    {
//        dd($_GET['contentIds']);
        foreach ($_GET['contentIds'] as $key => $id) {
            $content = Content::find($id);
            $content->sort = $key;
            $content->save();
        }
        return response()->json('success');
    }
}
