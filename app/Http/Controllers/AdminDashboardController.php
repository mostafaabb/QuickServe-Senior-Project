<?php

namespace App\Http\Controllers;

use App\Models\Order; // Assuming you have an Order model
use App\Models\User; // Assuming you have a User model
use Illuminate\Http\Request;

class AdminDashboardController extends Controller
{
    public function index()
    {
        // Fetch data to pass to the view
        $totalUsers = User::count(); // Get the total number of users
        $totalOrders = Order::count(); // Get the total number of orders
        $pendingRequests = Order::where('status', 'pending')->count(); // Get the number of pending requests
        $recentOrders = Order::latest()->take(5)->get(); // Get the 5 most recent orders

        return view('dashboard', compact('totalUsers', 'totalOrders', 'pendingRequests', 'recentOrders'));
    }
}


