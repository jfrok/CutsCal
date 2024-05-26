<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use Spatie\Permission\Models\Role;
use Spatie\Permission\Models\Permission;
use DB;

class RoleController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    function __construct()
    {
        $this->middleware('permission:role-list|role-create|role-edit|role-delete', ['only' => ['index', 'store']]);
        $this->middleware('permission:role-create', ['only' => ['create', 'store']]);
        $this->middleware('permission:role-edit', ['only' => ['edit', 'update', 'show']]);
        $this->middleware('permission:role-delete', ['only' => ['destroy']]);
    }

    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index(Request $request)
    {
//        $user = User::find(Auth::id());
        $rolesUsers = [];

        if (Auth::id() == 20 || Auth::user()->hasPermissionTo('role-access-all')) {
//            $roles = Role::orderBy('id')->paginate(10);
            $roles = DB::table('roles')
                ->join('users', 'roles.userId', '=', 'users.id')
                ->select('roles.*', 'users.name as user_name')
                ->orderBy('roles.id')
                ->paginate(10);
            $rolesData = Role::all();

            foreach ($rolesData as $role) {
                $rolesUsers[] = ['role' => $role->name, 'users' => User::role($role->name)->get()];
            }

        } else {
            $roles = DB::table('roles')
                ->join('users', 'roles.userId', '=', 'users.id')
                ->select('roles.*', 'users.name as user_name')
                ->where('roles.userId', User::findTheMainUser()->id)
                ->orderBy('roles.id')
                ->paginate(10);
        }

//        $test = User::role('writer')->get();
//        dd(\App\Models\Role::getRoleUsers('founder'));
        return inertia('Roles/Overview', ['roles' => $roles, 'rolesUsers' => $rolesUsers])
            ->with('i', ($request->input('page', 1) - 1) * 5);
    }

    public function getRoleUsers($roleName)
    {
        $users = User::role($roleName)->get();
        return back()->with($users);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        if (Auth::id() == 20 || Auth::user()->hasPermissionTo('role-access-all')) {
            $permission = Permission::select('id','name')->orderBy('name','DESC')->get();
        } else {
            $permission = Permission::select('id','name')->whereNotIn('name', \App\Models\Role::preventedPermission())->get();
        }
        return inertia('Roles/Create', ['permission' => $permission]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        /// uniq names debanse on the current user role
        $this->validate($request, [
            'name' => 'required|unique:roles,name',
            'permission' => 'required',
        ]);
        $role = Role::create(['name' => User::findTheMainUser()->id != 20 ? User::findTheMainUser()->id . '.' . $request->input('name') : $request->input('name'),
            'userId' => User::findTheMainUser()->id]);

        if ($role){
            $role->syncPermissions($request->input('permission'));
            return redirect()->route('roles.index')
                ->with('message', 'Role created successfully');
        }

        return redirect()->route('roles.index')
            ->with('error', 'Ops something wrong');
    }

    /**
     * Display the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        $role = Role::find($id);
        $rolePermissions = Permission::join("role_has_permissions", "role_has_permissions.permission_id", "=", "permissions.id")
            ->where("role_has_permissions.role_id", $id)
            ->get();
        return inertia('Roles/Show', ['role' => $role, 'rolePermissions' => $rolePermissions]);
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $role = Role::find($id);
        $permissions = Permission::select('id','name')->get();
        $rolePermissions = DB::table("role_has_permissions")->where("role_has_permissions.role_id", $id)
            ->pluck('role_has_permissions.permission_id', 'role_has_permissions.permission_id')
            ->all();
//        dd($rolePermissions);
        return inertia('Roles/Edit', ['role' => $role, 'permissions' => $permissions, 'rolePermissions' => $rolePermissions]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $this->validate($request, [
            'name' => 'required',
            'permission' => 'required',
        ]);
        if ($request->delPermission) {

            $permission = Permission::findById($request->delPermission);
        }
        //        dd($permission);
        if ($id != 6) {
            $role = Role::find($id);
            $role->name = $request->input('name');
            $role->save();
            $role->syncPermissions($request->input('permission'));
//            $role->revokePermissionTo($permission);
            if ($request->delPermission) {
                $permission->removeRole($role);
            }
            return back()
                ->with('message', 'Role updated successfully');
        }
        if (Auth::id() == 20 && $id == 6) {
            $role = Role::find($id);
            $role->name = $request->input('name');
            $role->save();
            $role->syncPermissions($request->input('permission'));
            return back()
                ->with('message', 'Role updated successfully');
        }
        return back()
            ->with('error', 'You can\'t edit on this role', 404);
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param int $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        $role = DB::table("roles")->where('id', $id);
        if ($id != 6 && $id != 10) {
            $role->delete();
            return redirect()->route('roles.index')
                ->with('message', 'Role deleted successfully');
        }
        return back()
            ->with('error', 'Ops something wrong!');
    }
}
