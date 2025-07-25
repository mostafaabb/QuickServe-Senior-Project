<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\Payment;
use App\Models\Order;
use App\Models\User;
use Illuminate\Http\Request;

class PaymentController extends Controller
{
    // Display payment history
    public function index()
    {
        $payments = Payment::with('order', 'user')->orderBy('created_at', 'desc')->paginate(10);  // Paginate payments
        return view('admin.payments.index', compact('payments'));
    }

    // Show the form for creating a new payment
    public function create()
    {
        $orders = Order::all();  // Get all orders
        $users = User::all();  // Get all users
        return view('admin.payments.create', compact('orders', 'users'));
    }

    // Store a newly created payment in storage
    public function store(Request $request)
    {
        $request->validate([
            'order_id' => 'required|exists:orders,id',
            'user_id' => 'required|exists:users,id',
            'amount' => 'required|numeric|min:0.01',
            'status' => 'required|string',
        ]);

        Payment::create([
            'order_id' => $request->order_id,
            'user_id' => $request->user_id,
            'amount' => $request->amount,
            'status' => $request->status,
        ]);

        return redirect()->route('admin.payments.index')->with('success', 'Payment created successfully');
    }

    // Show the form for editing the specified payment
    public function edit(Payment $payment)
    {
        $orders = Order::all();  // Get all orders
        $users = User::all();  // Get all users
        return view('admin.payments.edit', compact('payment', 'orders', 'users'));
    }

    // Update the specified payment in storage
    public function update(Request $request, Payment $payment)
    {
        $request->validate([
            'order_id' => 'required|exists:orders,id',
            'user_id' => 'required|exists:users,id',
            'amount' => 'required|numeric|min:0.01',
            'status' => 'required|string',
        ]);

        $payment->update([
            'order_id' => $request->order_id,
            'user_id' => $request->user_id,
            'amount' => $request->amount,
            'status' => $request->status,
        ]);

        return redirect()->route('admin.payments.index')->with('success', 'Payment updated successfully');
    }

    // Remove the specified payment from storage
    public function destroy(Payment $payment)
    {
        $payment->delete();
        return redirect()->route('admin.payments.index')->with('success', 'Payment deleted successfully');
    }
}
