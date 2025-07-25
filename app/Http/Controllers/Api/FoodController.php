<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Food;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class FoodController extends Controller
{
    // Display a listing of the food items
    public function index()
    {
        try {
            $foods = \App\Models\Food::all();
            return response()->json($foods);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Failed to get foods',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    // New method: Get trending foods (top 5 ordered in last 48 hours)
    public function getTrendingFoods()
    {
        try {
            // Get food_ids ordered in last 48 hours, sorted by number of orders descending
            $trendingFoodsIds = \DB::table('food_order')
                ->select('food_id', \DB::raw('COUNT(*) as orders_count'))
                ->where('created_at', '>=', now()->subDays(2))
                ->groupBy('food_id')
                ->orderByasc('orders_count')
                ->limit(5)
                ->pluck('food_id');

            // Fetch full food records
            $foods = Food::whereIn('id', $trendingFoodsIds)->get();

            return response()->json($foods);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Failed to get trending foods',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    // Store a newly created food item
    public function store(Request $request)
    {
        // Validate incoming request data
        $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'price' => 'required|numeric',
            'category_id' => 'required|exists:categories,id',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048', // validate image
        ]);

        // Handle image upload if present
        $imagePath = null;
        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('foods', 'public'); // store in public disk
        }

        // Create a new food item
        $food = Food::create([
            'name' => $request->name,
            'description' => $request->description,
            'price' => $request->price,
            'category_id' => $request->category_id,
            'image' => $imagePath, // store the file path
        ]);

        return response()->json($food, 201);
    }

    // Display the specified food item
    public function show($id)
    {
        $food = Food::findOrFail($id);
        return response()->json($food);
    }

    // Update the specified food item
    public function update(Request $request, $id)
    {
        $food = Food::findOrFail($id);

        // Validate incoming request data
        $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
            'price' => 'required|numeric',
            'category_id' => 'required|exists:categories,id',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048', // validate image
        ]);

        // Handle image upload if present
        if ($request->hasFile('image')) {
            // Delete old image if it exists and if it's a valid path
            if ($food->image && Storage::disk('public')->exists($food->image)) {
                Storage::disk('public')->delete($food->image);
            }

            // Store new image
            $imagePath = $request->file('image')->store('foods', 'public');
            $food->image = $imagePath; // update the image field
        }

        // Update the food item
        $food->update([
            'name' => $request->name,
            'description' => $request->description,
            'price' => $request->price,
            'category_id' => $request->category_id,
        ]);

        return response()->json($food);
    }

    // Remove the specified food item
    public function destroy($id)
    {
        $food = Food::findOrFail($id);

        // Delete image if it exists
        if ($food->image && Storage::disk('public')->exists($food->image)) {
            Storage::disk('public')->delete($food->image);
        }

        $food->delete();
        return response()->json(['message' => 'Food deleted successfully']);
    }
}
