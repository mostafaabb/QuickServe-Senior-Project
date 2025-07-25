<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Models\User;

class AdminController extends Controller
{
    public function index()
    {
        $pendingOrders = Order::where('status', 'pending')->count();
        $totalUsers = User::count();
        $totalOrders = Order::count();

        return view('admin.dashboard', compact('pendingOrders', 'totalUsers', 'totalOrders'));
    }
    // public function showRevenue()
    // {
    //     // Calculate total revenue (adjust if your column name is different)
    //     $totalRevenue = Order::sum('total_price'); // Ensure 'total_price' is the correct column name
    
    //     // Calculate total orders
    //     $totalOrders = Order::count(); // Count the total number of orders
    
    //     // Debugging step to check if the variables are correctly calculated
    //     dd($totalRevenue, $totalOrders);
    
    //     // Return the view with the calculated variables
    //     return view('admin.revenue', compact('totalRevenue', 'totalOrders'));
    // }
}
