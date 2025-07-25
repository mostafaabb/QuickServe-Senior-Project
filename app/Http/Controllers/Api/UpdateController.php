<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Food;
use App\Models\Offer;
use App\Models\Category;

class UpdateController extends Controller
{
    public function latestUpdates()
    {
        return response()->json([
            'foods' => Food::latest()->take(5)->get(),
            'offers' => Offer::latest()->take(5)->get(),
            'categories' => Category::latest()->take(5)->get(),
        ]);
    }
}
