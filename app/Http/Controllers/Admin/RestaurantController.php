<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Restaurant; // Import the Restaurant model
use Illuminate\Http\Request;

class RestaurantController extends Controller
{
    public function index()
    {
        $restaurants = Restaurant::paginate(10); // Paginate the restaurants for listing
        return view('admin.restaurants.index', compact('restaurants'));
    }

    public function create()
    {
        return view('admin.restaurants.create'); // Return the create view
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required',
            'location' => 'required',
            'description' => 'nullable',
            'contact' => 'nullable',
            'email' => 'nullable|email',
            'image' => 'nullable|image|max:2048', // For file upload validation
            'hours' => 'nullable',
        ]);

        // Handle image upload
        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('restaurants', 'public');
        }

        Restaurant::create([
            'name' => $request->name,
            'location' => $request->location,
            'description' => $request->description,
            'contact' => $request->contact,
            'email' => $request->email,
            'image' => $imagePath ?? null,
            'hours' => $request->hours,
        ]);

        return redirect()->route('admin.restaurants.index')->with('success', 'Restaurant added successfully!');
    }

    public function edit(Restaurant $restaurant)
    {
        return view('admin.restaurants.edit', compact('restaurant')); // Pass restaurant to edit view
    }

    public function update(Request $request, Restaurant $restaurant)
    {
        $request->validate([
            'name' => 'required',
            'location' => 'required',
            'description' => 'nullable',
            'contact' => 'nullable',
            'email' => 'nullable|email',
            'image' => 'nullable|image|max:2048',
            'hours' => 'nullable',
        ]);

        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('restaurants', 'public');
            $restaurant->image = $imagePath;
        }

        $restaurant->update([
            'name' => $request->name,
            'location' => $request->location,
            'description' => $request->description,
            'contact' => $request->contact,
            'email' => $request->email,
            'hours' => $request->hours,
        ]);

        return redirect()->route('admin.restaurants.index')->with('success', 'Restaurant updated successfully!');
    }

    public function destroy(Restaurant $restaurant)
    {
        $restaurant->delete();
        return redirect()->route('admin.restaurants.index')->with('success', 'Restaurant deleted successfully!');
    }
}
