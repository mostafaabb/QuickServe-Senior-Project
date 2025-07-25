@extends('admin.layout')

@section('content')
<div class="container-fluid py-4">
    <div class="card shadow-sm border-0 rounded">
        <div class="card-header bg-warning text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0">📦 All Orders</h4>
        </div>

        <div class="card-body">
            <!-- Navigation buttons -->
            <div class="mb-3">
                <a href="{{ route('admin.orders.pending') }}" class="btn btn-warning me-2">🕒 Pending</a>
                <a href="{{ route('admin.orders.canceled') }}" class="btn btn-danger me-2">❌ Canceled</a>
                <a href="{{ route('admin.orders.completed') }}" class="btn btn-success">✅ Completed</a>
            </div>

            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle">
                    <thead class="bg-warning text-white">
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
                        @forelse($orders as $order)
                            <tr>
                                <td>{{ $loop->iteration }}</td>
                                <td>{{ $order->id }}</td>
                                <td>{{ $order->user->name ?? 'N/A' }}</td>
                                <td>
                                    <ul class="mb-0 ps-3">
                                        @foreach($order->foods as $food)
                                            <li>{{ $food->name }} (x{{ $food->pivot->quantity }}) - ${{ number_format($food->pivot->price, 2) }}</li>
                                        @endforeach
                                    </ul>
                                </td>
                                <td>
                                    @php
                                        $statusColors = [
                                            'pending' => 'badge bg-warning text-dark',
                                            'completed' => 'badge bg-success',
                                            'canceled' => 'badge bg-danger',
                                        ];
                                        $colorClass = $statusColors[$order->status] ?? 'badge bg-secondary';
                                    @endphp
                                    <span class="{{ $colorClass }}">{{ ucfirst($order->status) }}</span>
                                </td>
                                <td>${{ number_format($order->total_price, 2) }}</td>
                                <td>{{ $order->delivery_address }}</td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="7" class="text-center text-muted py-4">No orders found.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
@endsection
