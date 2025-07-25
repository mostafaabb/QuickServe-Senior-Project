<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Order;

class OrderSeeder extends Seeder
{
    public function run()
    {
        // Create 10 orders using a factory
        Order::factory()->count(10)->create();
    }
}
