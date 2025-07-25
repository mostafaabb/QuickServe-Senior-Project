<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Order;
use App\Models\Food;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;

class OrderController extends Controller
{
    /**
     * Get all orders with user and food details.
     *
     * @return JsonResponse
     */
    public function index(): JsonResponse
    {
        $orders = Order::with('user', 'food')->get();

        return response()->json([
            'status' => true,
            'message' => 'Orders retrieved successfully.',
            'data' => $orders,
        ]);
    }

    /**
     * Create a new order.
     *
     * @param  Request  $request
     * @return JsonResponse
     */
  public function store(Request $request)
{
    $request->validate([
        'user_id' => 'required|exists:users,id',
        'delivery_address' => 'required|string',
        'foods' => 'required|array',
        'foods.*.food_id' => 'required|exists:food,id',
        'foods.*.quantity' => 'required|integer|min:1',
        'user_notes' => 'nullable|string|max:255',
    ]);

    $total = 0;
    $foodsData = [];

    foreach ($request->foods as $item) {
        $food = Food::findOrFail($item['food_id']);
        $quantity = $item['quantity'];
        $price = $food->price;
        $total += $price * $quantity;

        $foodsData[$item['food_id']] = [
            'quantity' => $quantity,
            'price' => $price,
        ];
    }

    $order = Order::create([
        'user_id' => $request->user_id,
        'delivery_address' => $request->delivery_address,
        'status' => 'pending',
        'total_price' => $total,
        'user_notes' => $request->user_notes,
    ]);

    $order->foods()->attach($foodsData);

    return response()->json([
        'message' => 'Order created successfully',
        'data' => $order->load('foods')
    ]);
}


    /**
     * Update order status.
     *
     * @param  Request  $request
     * @param  int  $id
     * @return JsonResponse
     */
    public function updateStatus(Request $request, $id): JsonResponse
    {
        $order = Order::findOrFail($id);

        $request->validate([
            'status' => 'required|in:pending,completed,canceled',
        ]);

        $order->status = $request->status;
        $order->save();

        return response()->json([
            'status' => true,
            'message' => 'Order status updated successfully.',
            'data' => $order,
        ]);
    }
}
