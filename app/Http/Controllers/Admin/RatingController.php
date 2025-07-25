<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Rating;

class RatingController extends Controller
{
    public function index()
    {
        // You can paginate or fetch all ratings
        $ratings = Rating::with('user')->orderBy('created_at', 'asc')->paginate(20);

        return view('admin.ratings.index', compact('ratings'));
    }
}
