<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Models\User;
use App\Models\Food;
use Illuminate\Http\Request;

class OrderController extends Controller
{
    public function index()
    {
        $orders = Order::with('user', 'foods')->orderBy('created_at', 'asc')->get();
        return view('admin.orders.index', compact('orders'));
    }

    public function show($id)
    {
        $order = Order::with('user', 'foods')->findOrFail($id);
        return view('admin.orders.show', compact('order'));
    }

    public function create()
    {
        $users = User::all();
        $foods = Food::all();
        return view('admin.orders.create', compact('users', 'foods'));
    }

    public function store(Request $request)
    {
        $request->validate([
            'user_id' => 'required|exists:users,id',
            'delivery_address' => 'required|string',
            'foods' => 'required|array',
            'foods.*.food_id' => 'required|exists:food,id',
            'foods.*.quantity' => 'required|integer|min:1',
            'status' => 'required|in:pending,completed,cancelled',
        ]);

        $total_price = 0;
        $foodsData = [];

        foreach ($request->foods as $item) {
            $food = Food::findOrFail($item['food_id']);
            $quantity = $item['quantity'];
            $price = $food->price;
            $total_price += $price * $quantity;

            $foodsData[$food->id] = [
                'quantity' => $quantity,
                'price' => $price,
            ];
        }

        $order = Order::create([
            'user_id' => $request->user_id,
            'delivery_address' => $request->delivery_address,
            'status' => $request->status,
            'total_price' => $total_price,
        ]);

        $order->foods()->attach($foodsData);

        return redirect()->route('admin.orders.index')->with('success', 'Order created successfully.');
    }

    public function edit($id)
    {
        $order = Order::with('foods')->findOrFail($id);
        $users = User::all();
        $foods = Food::all();
        return view('admin.orders.edit', compact('order', 'users', 'foods'));
    }

    public function update(Request $request, $id)
    {
        $order = Order::findOrFail($id);

        $request->validate([
            'user_id' => 'required|exists:users,id',
            'delivery_address' => 'required|string',
            'foods' => 'required|array',
            'foods.*.food_id' => 'required|exists:food,id',
            'foods.*.quantity' => 'required|integer|min:1',
            'status' => 'required|in:pending,completed,cancelled',
        ]);

        $total_price = 0;
        $foodsData = [];

        foreach ($request->foods as $item) {
            $food = Food::findOrFail($item['food_id']);
            $quantity = $item['quantity'];
            $price = $food->price;
            $total_price += $price * $quantity;

            $foodsData[$food->id] = [
                'quantity' => $quantity,
                'price' => $price,
            ];
        }

        $order->update([
            'user_id' => $request->user_id,
            'delivery_address' => $request->delivery_address,
            'status' => $request->status,
            'total_price' => $total_price,
        ]);

        $order->foods()->sync($foodsData);

        return redirect()->route('admin.orders.index')->with('success', 'Order updated successfully.');
    }

    public function destroy($id)
    {
        $order = Order::findOrFail($id);
        $order->foods()->detach();
        $order->delete();

        return redirect()->route('admin.orders.index')->with('success', 'Order deleted successfully.');
    }

    public function updateStatus(Request $request, $id)
    {
        $request->validate([
            'status' => 'required|in:pending,completed,cancelled',
        ]);

        $order = Order::findOrFail($id);
        $order->status = $request->status;
        $order->save();

        return redirect()->route('admin.orders.index')->with('success', 'Order status updated.');
    }

    public function pending()
    {
        $pendingOrders = Order::where('status', 'pending')->with('user', 'foods')->get();
        return view('admin.orders.pending', compact('pendingOrders'));
    }

    public function canceled()
    {
        $canceledOrders = Order::where('status', 'cancelled')->with('user', 'foods')->get();
        return view('admin.orders.canceled', compact('canceledOrders'));
    }

    public function completed()
    {
        $completedOrders = Order::where('status', 'completed')->with('user', 'foods')->get();
        return view('admin.orders.completed', compact('completedOrders'));
    }
}
