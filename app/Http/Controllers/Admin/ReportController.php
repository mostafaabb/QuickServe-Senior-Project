<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Food;
use App\Models\Order;
use App\Models\User;
use Illuminate\Http\Request;

class ReportController extends Controller
{
    public function index()
    {
        $totalRevenue = Order::sum('total_price');
        $totalOrders = Order::count();
        $totalUsers = User::count();

        // Make sure this relationship exists in Food model:
        // public function orders() { return $this->hasMany(Order::class); }
        $topFood = Food::withCount('orders')
                    ->orderByDesc('orders_count')
                    ->first();

        $chartLabels = ['Jan', 'Feb', 'Mar', 'Apr', 'May'];
        $chartData = [100, 200, 150, 300, 250];

        return view('admin.reports', compact(
            'totalRevenue',
            'totalOrders',
            'totalUsers',
            'topFood',
            'chartLabels',
            'chartData'
        ));
    }

    public function foodSalesReport()
    {
        $foodSales = Food::withCount('orders')
                        ->orderBy('orders_count', 'desc')
                        ->get();

        return view('admin.reports.food_sales', compact('foodSales'));
    }

    public function orderReport(Request $request)
    {
        $request->validate([
            'start_date' => 'required|date',
            'end_date' => 'required|date',
        ]);

        $start = date('Y-m-d 00:00:00', strtotime($request->start_date));
        $end = date('Y-m-d 23:59:59', strtotime($request->end_date));

        $orders = Order::whereBetween('created_at', [$start, $end])->get();

        return view('admin.reports.order_report', compact('orders'));
    }
}
