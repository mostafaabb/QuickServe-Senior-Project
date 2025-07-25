<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Rating;

class RatingController extends Controller
{
    /**
     * Store a new rating submitted by any user (no auth required).
     */
    public function store(Request $request)
    {
        $request->validate([
            'rating' => 'required|integer|min:1|max:5',
            'comment' => 'nullable|string|max:500',
            'user_id' => 'nullable|integer|exists:users,id',  // optional user_id validation
        ]);

        $rating = Rating::create([
            'user_id' => $request->input('user_id'), // use user_id from request, nullable
            'rating' => $request->rating,
            'comment' => $request->comment,
        ]);

        return response()->json([
            'message' => 'Rating submitted successfully',
            'rating' => $rating,
        ], 201);
    }

    /**
     * Return average rating and total count of ratings.
     */
    public function averageRating()
    {
        $avg = Rating::avg('rating');
        $count = Rating::count();

        return response()->json([
            'average_rating' => round($avg, 2),
            'count' => $count,
        ]);
    }
}
