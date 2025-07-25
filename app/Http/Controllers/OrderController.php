<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Order;

class OrderController extends Controller
{
    // Show all orders
    public function index()
    {
        $orders = Order::all();
        return view('admin.orders.index', compact('orders'));
    }

    // Show form to create new order
    public function create()
    {
        return view('admin.orders.create');
    }

    // Store new order
    public function store(Request $request)
    {
        $request->validate([
            'status' => 'required|string'
        ]);

        Order::create([
            'status' => $request->status
        ]);

        return redirect()->route('admin.orders.index')->with('success', 'Order created successfully.');
    }

    // Show edit form
    public function edit($id)
    {
        $order = Order::findOrFail($id);
        return view('admin.orders.edit', compact('order'));
    }

    // Update order
    public function update(Request $request, $id)
    {
        $request->validate([
            'status' => 'required|string'
        ]);

        $order = Order::findOrFail($id);
        $order->status = $request->status;
        $order->save();

        return redirect()->route('admin.orders.index')->with('success', 'Order updated successfully.');
    }

    // Delete order
    public function destroy($id)
    {
        $order = Order::findOrFail($id);
        $order->delete();

        return redirect()->route('admin.orders.index')->with('success', 'Order deleted.');
    }
    public function pending()
    {
        // Fetch all pending orders from the database
        $pendingOrders = Order::where('status', 'pending')->get();

        // Return the view with pending orders data
        return view('admin.orders.pending', compact('pendingOrders'));
    }
// In app/Http/Controllers/OrderController.php
public function show($id)
{
    $order = Order::findOrFail($id);
    return view('admin.orders.show', compact('order'));
}


}
