<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\DB;
class Role extends Model
{
    use HasFactory;

//    public function user()
//    {
//        return $this->belongsTo(User::class, 'userId');
//    }
    static function getRoleUsers($roleName)
    {
        $users = User::role($roleName)->get();

        return $users;
    }

    static function preventedPermission()
    {
        $permission = [
            'user-list', 'user-create', 'user-delete', 'user-edit',
            'project-list', 'project-create', 'project-edit', 'project-delete',
            'content-list', 'content-create', 'content-edit', 'content-delete', 'project-api', 'role-access-all'];
        return $permission;
    }

    static function getDirectPermission($uId)
    {
        $permissions = DB::table('model_has_permissions')
            ->join('permissions', 'model_has_permissions.permission_id', 'permissions.id')
            ->select('permissions.*')->where('model_id', $uId)->get()->toArray();

//        if ($permissions) {
            return $permissions;
//        }
    }
}
