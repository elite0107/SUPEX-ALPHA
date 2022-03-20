<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Category;

class CategorySeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        Category::create([
            'category' => 'Javascript'
        ]);

        Category::create([
            'category' => 'PHP'
        ]);

        Category::create([
            'parent_id' => 1,
            'category' => 'Angular.js'
        ]);

        Category::create([
            'parent_id' => 1,
            'category' => 'React.js'
        ]);

        Category::create([
            'parent_id' => 1,
            'category' => 'Vue.js'
        ]);

        Category::create([
            'parent_id' => 1,
            'category' => 'Gatsby.js'
        ]);

        Category::create([
            'parent_id' => 2,
            'category' => 'Laravel'
        ]);

        Category::create([
            'parent_id' => 2,
            'category' => 'CodeIgnitor'
        ]);

        Category::create([
            'parent_id' => 2,
            'category' => 'WordPress'
        ]);

        Category::create([
            'parent_id' => 2,
            'category' => 'Magento'
        ]);
    }
}
