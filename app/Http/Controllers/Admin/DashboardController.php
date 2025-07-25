<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\User;
use App\Models\Order;

class DashboardController extends Controller
{
    public function index()
    {
        return view('admin.dashboard', [
            'totalUsers' => User::count(),
            'totalOrders' => Order::count(),
            'pendingOrders' => Order::where('status', 'pending')->count(),
            'totalRevenue' => Order::sum('total_price'), // fixed column name
            'chartLabels' => ['Jan', 'Feb', 'Mar', 'Apr', 'May'], // example months
            'chartData' => [5, 10, 8, 15, 12], // example order counts
        ]);
    }
    
    public function revenue()
    {
        $totalOrders = Order::count();
        $totalRevenue = Order::sum('total_price'); // fixed column name
    
        return view('admin.revenue', compact('totalOrders', 'totalRevenue'));
    }
}
