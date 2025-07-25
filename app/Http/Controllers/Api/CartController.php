<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\CartItem;
use Illuminate\Http\Request;

class CartController extends Controller
{
    public function addToCart(Request $request)
    {
        $request->validate([
            'user_id' => 'required|exists:users,id', // <-- user_id required
            'food_id' => 'required|exists:food,id',
            'quantity' => 'required|integer|min:1',
        ]);

        
        $userId = $request->user_id;

        $cartItem = CartItem::updateOrCreate(
            ['user_id' => $userId, 'food_id' => $request->food_id],
            ['quantity' => $request->quantity]
        );

        return response()->json([
            'status' => true,
            'message' => 'Item added to cart successfully.',
            'data' => $cartItem,
        ]);
    }

    public function getCart(Request $request)
    {
        $request->validate([
            'user_id' => 'required|exists:users,id',
        ]);

        $userId = $request->user_id;

        $cartItems = CartItem::with('food')->where('user_id', $userId)->get();

        return response()->json([
            'status' => true,
            'data' => $cartItems,
        ]);
    }
}
