@extends('admin.layout')

@section('content')
<div class="container-fluid py-4">
    <h1 class="display-4">Pending Orders</h1>

    <a href="{{ route('admin.orders.index') }}" class="btn btn-primary mb-3">All Orders</a>

    <div class="row">
        <div class="col-12">
            <div class="card">
                <div class="card-header">
                    <h5 class="card-title mb-0">Pending Orders List</h5>
                </div>
                <div class="card-body">
                    <table class="table table-striped">
                        <thead class="table-dark">
                            <tr>
                                <th>#</th>
                                <th>Order ID</th>
                                <th>Customer</th>
                                <th>Items</th>
                                <th>Status</th>
                                <th>Total Price</th>
                                <th>Delivery Address</th>
                            </tr>
                        </thead>
                        <tbody>
                            @forelse($pendingOrders as $order)
                                <tr>
                                    <td>{{ $loop->iteration }}</td>
                                    <td>{{ $order->id }}</td>
                                    <td>{{ $order->user->name ?? 'N/A' }}</td>
                                    <td>
                                        <ul>
                                            @foreach($order->foods as $food)
                                                <li>{{ $food->name }} (x{{ $food->pivot->quantity }}) - ${{ number_format($food->pivot->price, 2) }}</li>
                                            @endforeach
                                        </ul>
                                    </td>
                                    <td><span class="badge bg-warning text-dark">Pending</span></td>
                                    <td>${{ number_format($order->total_price, 2) }}</td>
                                    <td>{{ $order->delivery_address }}</td>
                                </tr>
                            @empty
                                <tr><td colspan="7" class="text-center">No pending orders.</td></tr>
                            @endforelse
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
