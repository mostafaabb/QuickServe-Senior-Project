<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller; // <-- Add this line
use App\Models\User;
use App\Models\Order;
use App\Models\Food;
use Illuminate\Http\Request;

class SearchController extends Controller
{
    public function index(Request $request)
    {
        $query = $request->input('query'); // Get search query

        // Perform searches
        $users = User::where('name', 'like', "%{$query}%")
                     ->orWhere('email', 'like', "%{$query}%")
                     ->get();

        $orders = Order::where('order_number', 'like', "%{$query}%")
                       ->orWhere('status', 'like', "%{$query}%")
                       ->get();

        $foods = Food::where('name', 'like', "%{$query}%")
                     ->orWhere('description', 'like', "%{$query}%")
                     ->get();

        return view('admin.search', compact('users', 'orders', 'foods'));
    }
}
