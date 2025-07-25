<?php

namespace App\Http\Controllers\Frontend;

use App\Models\Food;
use Illuminate\Http\Request;
use App\Http\Controllers\Controller;

class HomeController extends Controller
{
    public function index()
    {
        $foods = Food::all(); // Get all foods from the database
        return view('home', compact('foods'));
    }
}

