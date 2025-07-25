<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Restaurant;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class RestaurantController extends Controller
{
    /**
     * Return a list of all restaurants.
     *
     * @return JsonResponse
     */
    public function index(): JsonResponse
    {
        $restaurants = Restaurant::all(); // You can add relations or additional filters if needed.

        return response()->json([
            'status' => true,
            'message' => 'Restaurants retrieved successfully.',
            'data' => $restaurants,
        ]);
    }

    /**
     * Store a new restaurant.
     *
     * @param  Request  $request
     * @return JsonResponse
     */
    public function store(Request $request): JsonResponse
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'location' => 'required|string|max:255',
            'description' => 'nullable|string',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        $restaurant = new Restaurant([
            'name' => $request->name,
            'location' => $request->location,
            'description' => $request->description,
        ]);

        // Handle image upload if provided
        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('uploads', 'public');
            $restaurant->image = $imagePath;
        }

        $restaurant->save();

        return response()->json([
            'status' => true,
            'message' => 'Restaurant created successfully.',
            'data' => $restaurant,
        ], 201);
    }

    /**
     * Update an existing restaurant.
     *
     * @param  Request  $request
     * @param  int  $id
     * @return JsonResponse
     */
    public function update(Request $request, $id): JsonResponse
    {
        $restaurant = Restaurant::findOrFail($id);

        $request->validate([
            'name' => 'required|string|max:255',
            'location' => 'required|string|max:255',
            'description' => 'nullable|string',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);

        $restaurant->name = $request->name;
        $restaurant->location = $request->location;
        $restaurant->description = $request->description;

        // Handle image upload if provided
        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('uploads', 'public');
            $restaurant->image = $imagePath;
        }

        $restaurant->save();

        return response()->json([
            'status' => true,
            'message' => 'Restaurant updated successfully.',
            'data' => $restaurant,
        ]);
    }

    /**
     * Delete a restaurant.
     *
     * @param  int  $id
     * @return JsonResponse
     */
    public function destroy($id): JsonResponse
    {
        $restaurant = Restaurant::findOrFail($id);
        $restaurant->delete();

        return response()->json([
            'status' => true,
            'message' => 'Restaurant deleted successfully.',
        ]);
    }
}
