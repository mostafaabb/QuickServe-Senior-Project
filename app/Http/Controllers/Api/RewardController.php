<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Reward;
use Illuminate\Http\Request;
use Illuminate\Support\Str;

class RewardController extends Controller
{
    // Get all rewards for the given user_id (passed as query parameter)
    public function index(Request $request)
    {
        $userId = $request->query('user_id');

        if (!$userId) {
            return response()->json(['error' => 'Missing user_id parameter'], 400);
        }

        $rewards = Reward::where('user_id', $userId)->get();

        if ($rewards->isEmpty()) {
            return response()->json(['message' => 'No rewards found for this user'], 404);
        }

        return response()->json($rewards);
    }

    // Create a new reward for the given user_id (passed in POST body)
    public function store(Request $request)
    {
        $request->validate([
            'user_id' => 'required|integer|exists:users,id',
            'title' => 'required|string',
            'discount_amount' => 'required|numeric|min:1',
        ]);

        $reward = Reward::create([
            'user_id' => $request->user_id,
            'title' => $request->title,
            'code' => strtoupper(Str::random(8)),
            'discount_amount' => $request->discount_amount,
            'used' => false,
        ]);

        return response()->json($reward, 201);
    }

    // Validate and redeem a reward code for a user
    public function redeem(Request $request)
    {
        $request->validate([
            'user_id' => 'required|integer|exists:users,id',
            'code' => 'required|string',
        ]);

        $reward = Reward::where('user_id', $request->user_id)
            ->where('code', $request->code)
            ->where('used', false)
            ->first();

        if (!$reward) {
            return response()->json(['error' => 'Invalid or already used reward code'], 400);
        }

        return response()->json([
            'message' => 'Reward code is valid',
            'reward' => $reward,
        ]);
    }

    // Mark a reward as used after order confirmation
    public function markUsed($id)
    {
        $reward = Reward::find($id);

        if (!$reward) {
            return response()->json(['error' => 'Reward not found'], 404);
        }

        if ($reward->used) {
            return response()->json(['error' => 'Reward already used'], 400);
        }

        $reward->used = true;
        $reward->save();

        return response()->json(['message' => 'Reward marked as used']);
    }
}
