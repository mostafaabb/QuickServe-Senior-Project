<?php

namespace App\Http\Controllers;

use App\Models\Food;
use Illuminate\Http\Request;

class FoodController extends Controller
{
    // Display a listing of the foods
    public function index()
    {
        $foods = Food::all();
        return view('admin.food.index', compact('foods'));
    }

    // Show the form for creating a new food
    public function create()
    {
        return view('admin.food.create');
    }

    // Store a newly created food
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'price' => 'required|numeric',
            'description' => 'nullable|string',
            'category' => 'nullable|string',
            'image' => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
        ]);

        $data = $request->all();

        if ($request->hasFile('image')) {
            $data['image'] = $request->file('image')->store('foods', 'public');
        }

        Food::create($data);

        return redirect()->route('food.index')->with('success', 'Food item added successfully.');
    }

    // Show the form for editing the specified food
    public function edit($id)
    {
        $food = Food::findOrFail($id);
        return view('admin.food.edit', compact('food'));
    }

    // Update the specified food
    public function update(Request $request, $id)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'price' => 'required|numeric',
            'description' => 'nullable|string',
            'category' => 'nullable|string',
            'image' => 'nullable|image|mimes:jpg,jpeg,png|max:2048',
        ]);

        $food = Food::findOrFail($id);
        $data = $request->all();

        if ($request->hasFile('image')) {
            $data['image'] = $request->file('image')->store('foods', 'public');
        }

        $food->update($data);

        return redirect()->route('food.index')->with('success', 'Food item updated successfully.');
    }

    // Remove the specified food
    public function destroy($id)
    {
        $food = Food::findOrFail($id);
        $food->delete();
        return redirect()->route('food.index')->with('success', 'Food item deleted successfully.');
    }
}
