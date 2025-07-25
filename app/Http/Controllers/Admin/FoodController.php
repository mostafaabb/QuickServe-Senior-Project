<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Food;
use App\Models\Category;

class FoodController extends Controller
{
    // Display a listing of the food items
    public function index(Request $request)
{
    $query = Food::with('category');

    if ($search = $request->input('search')) {
        $query->where('name', 'LIKE', "%{$search}%");
    }

     $foods = $query->orderBy('id', 'asc')->get(); // you can use ->paginate(10) if you want pagination

    return view('admin.foods.index', compact('foods'));
}

    // Show the form for creating a new food item
    public function create()
    {
        $categories = Category::all(); // Fetch all categories
        return view('admin.foods.create', compact('categories'));
    }

    // Store a newly created food item in storage
    public function store(Request $request)
    {
        // Validate the incoming request
        $request->validate([
            'name' => [
                'required',
                'string',
                'max:255',
                'regex:/^[a-zA-Z\s]+$/', // Only letters and spaces allowed
            ],
            'price' => 'required|numeric|min:0.01', // Price must be a positive number
            'description' => 'required|string',
            'category_id' => 'nullable|exists:categories,id',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048', // Validate image file
        ]);

        // Handle image upload
        $imagePath = null;
        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('uploads', 'public');
        }

        // Create the new food item
        Food::create([
            'name' => $request->name,
            'price' => $request->price,
            'description' => $request->description,
            'category_id' => $request->category_id,
            'image' => $imagePath,
        ]);

        // Redirect to the food index with success message
        return redirect()->route('admin.foods.index')->with('success', 'Food item created successfully.');
    }

    // Show the form for editing the specified food item
    public function edit(Food $food)
    {
        $categories = Category::all(); // Fetch all categories
        return view('admin.foods.edit', compact('food', 'categories')); // Pass both food and categories to the view
    }

    // Update the specified food item in storage
    public function update(Request $request, $id)
    {
        // Validate the incoming request
        $request->validate([
            'name' => [
                'required',
                'string',
                'max:255',
                'regex:/^[a-zA-Z\s]+$/', // Only letters and spaces allowed
            ],
            'price' => 'required|numeric|min:0.01',
            'description' => 'required|string',
            'category_id' => 'nullable|exists:categories,id',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif|max:2048',
        ]);
    
        // Find the food item
        $food = Food::findOrFail($id);
    
        // Handle image upload if provided
        if ($request->hasFile('image')) {
            $imagePath = $request->file('image')->store('uploads', 'public');
            $food->image = $imagePath;
        }
    
        // Update food properties
        $food->name = $request->name;
        $food->price = $request->price;
        $food->description = $request->description;
        $food->category_id = $request->category_id;
    
        // Save the changes
        $food->save();
    
        // Redirect back with success message
        return redirect()->route('admin.foods.index')->with('success', 'Food item updated successfully.');
    }
    
    

    // Remove the specified food item from storage
    public function destroy(Food $food)
    {
        $food->delete();

        return redirect()->route('admin.foods.index')->with('success', 'Food item deleted successfully.');
    }
}
