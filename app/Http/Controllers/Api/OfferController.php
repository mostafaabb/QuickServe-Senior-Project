<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Offer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class OfferController extends Controller
{
    // List all offers
    public function index()
    {
        try {
            $offers = Offer::all();
            return response()->json(['data' => $offers], 200);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Failed to get offers',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    // Store a new offer
    public function store(Request $request)
    {
        try {
            $request->validate([
                'restaurant_id' => 'required|exists:restaurants,id',
                'title' => 'required|string|max:255',
                'description' => 'nullable|string',
                'discount' => 'nullable|numeric|min:0|max:100',
                'start_date' => 'required|date',
                'end_date' => 'required|date|after_or_equal:start_date',
                'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            ]);

            $imagePath = null;
            if ($request->hasFile('image')) {
                $imagePath = $request->file('image')->store('offers', 'public');
            }

            $offer = Offer::create([
                'restaurant_id' => $request->restaurant_id,
                'title' => $request->title,
                'description' => $request->description,
                'discount' => $request->discount,
                'start_date' => $request->start_date,
                'end_date' => $request->end_date,
                'image' => $imagePath,
            ]);

            return response()->json([
                'message' => 'Offer created successfully',
                'data' => $offer
            ], 201);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Failed to create offer',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    // Show a specific offer
    public function show($id)
    {
        try {
            $offer = Offer::findOrFail($id);
            return response()->json(['data' => $offer]);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Offer not found',
                'message' => $e->getMessage(),
            ], 404);
        }
    }

    // Update an existing offer
    public function update(Request $request, $id)
    {
        try {
            $offer = Offer::findOrFail($id);

            $request->validate([
                'restaurant_id' => 'required|exists:restaurants,id',
                'title' => 'required|string|max:255',
                'description' => 'nullable|string',
                'discount' => 'nullable|numeric|min:0|max:100',
                'start_date' => 'required|date',
                'end_date' => 'required|date|after_or_equal:start_date',
                'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
            ]);

            $data = $request->only([
                'restaurant_id', 'title', 'description', 'discount', 'start_date', 'end_date'
            ]);

            if ($request->hasFile('image')) {
                if ($offer->image && Storage::disk('public')->exists($offer->image)) {
                    Storage::disk('public')->delete($offer->image);
                }

                $data['image'] = $request->file('image')->store('offers', 'public');
            }

            $offer->update($data);

            return response()->json([
                'message' => 'Offer updated successfully',
                'data' => $offer
            ]);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Failed to update offer',
                'message' => $e->getMessage(),
            ], 500);
        }
    }

    // Delete an offer
    public function destroy($id)
    {
        try {
            $offer = Offer::findOrFail($id);

            if ($offer->image && Storage::disk('public')->exists($offer->image)) {
                Storage::disk('public')->delete($offer->image);
            }

            $offer->delete();

            return response()->json(['message' => 'Offer deleted successfully']);
        } catch (\Exception $e) {
            return response()->json([
                'error' => 'Failed to delete offer',
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
