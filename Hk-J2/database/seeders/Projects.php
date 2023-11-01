<?php

namespace Database\Seeders;

use Faker\Factory;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class Projects extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $projects = [];
        $faker = Factory::create();
        foreach (range(1,30) as $index){
            $project = [
                'title' => $faker->title(),
                'description' => $faker->text(55),
                'path' => $faker->filePath(),
                'created_at' => now(),
                'updated_at' => now(),

            ];
            $projects[] = $project;
        }
        DB::table('projects')->delete();
        DB::table('projects')->insert($projects);

    }
}
