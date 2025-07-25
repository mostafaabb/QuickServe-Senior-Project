<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Offer;
use App\Models\Restaurant;  // <-- Import Restaurant model
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;

class OfferController extends Controller
{
    // List all offers
    public function index()
    {
        $offers = Offer::all();
        return view('admin.offers.index', compact('offers'));
    }

    // Show form to create a new offer
    public function create()
    {
        $restaurants = Restaurant::all(); // Pass restaurants for select dropdown
        return view('admin.offers.create', compact('restaurants'));
    }

    // Store a new offer
    public function store(Request $request)
    {
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

        Offer::create([
            'restaurant_id' => $request->restaurant_id,
            'title' => $request->title,
            'description' => $request->description,
            'discount' => $request->discount,
            'start_date' => $request->start_date,
            'end_date' => $request->end_date,
            'image' => $imagePath,
        ]);

        return redirect()->route('admin.offers.index')->with('success', 'Offer created successfully.');
    }

    // Show form to edit an offer
    public function edit($id)
    {
        $offer = Offer::findOrFail($id);
        $restaurants = Restaurant::all(); // Pass restaurants for select dropdown
        return view('admin.offers.edit', compact('offer', 'restaurants'));
    }

    // Update an existing offer
    public function update(Request $request, $id)
    {
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

        if ($request->hasFile('image')) {
            // Delete old image if exists
            if ($offer->image && Storage::disk('public')->exists($offer->image)) {
                Storage::disk('public')->delete($offer->image);
            }

            $imagePath = $request->file('image')->store('offers', 'public');
            $offer->image = $imagePath;
        }

        $offer->restaurant_id = $request->restaurant_id;
        $offer->title = $request->title;
        $offer->description = $request->description;
        $offer->discount = $request->discount;
        $offer->start_date = $request->start_date;
        $offer->end_date = $request->end_date;

        $offer->save();

        return redirect()->route('admin.offers.index')->with('success', 'Offer updated successfully.');
    }

    // Delete an offer
    public function destroy($id)
    {
        $offer = Offer::findOrFail($id);

        if ($offer->image && Storage::disk('public')->exists($offer->image)) {
            Storage::disk('public')->delete($offer->image);
        }

        $offer->delete();

        return redirect()->route('admin.offers.index')->with('success', 'Offer deleted successfully.');
    }
}
