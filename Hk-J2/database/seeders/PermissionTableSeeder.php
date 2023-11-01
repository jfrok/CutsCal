<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;

class PermissionTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        $permissions = [
            'role-list',
            'role-access-all',
            'role-create',
            'role-edit',
            'role-delete',
            'user-list',
            'user-create',
            'user-edit',
            'user-delete',
            'event-calendar',
            'event-list',
            'event-create',
            'event-edit',
            'event-delete',
            'schedule-list',
            'schedule-edit',
            'employer-list',
            'employer-create',
            'employer-edit',
            'employer-delete',
            'employer-set-schedule',
            'frame',
            'client-list',
            'client-create',
            'client-edit',
            'client-delete',
            'frame',
            'note-list',
            'note-create',
            'note-delete',
            'project-list',
            'project-create',
            'project-edit',
            'project-delete',
            'project-api',
            'content-list',
            'content-create',
            'content-edit',
            'content-delete',
            'UI-edit',
            'trash-list',
            'trash-restore',
            'trash-force-delete',
        ];

        foreach ($permissions as $permission) {
            Permission::updateOrCreate([
                'name' => $permission,
            ]);
        }
    }
}
