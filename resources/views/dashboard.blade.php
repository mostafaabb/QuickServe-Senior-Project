@extends('layouts.dashboard_layout')

@section('content')
    <h2>Welcome to the Admin Dashboard</h2>
    <p>This is where you can manage users, view orders, and configure settings.</p>

    <!-- Stats Row -->
    <div class="row mt-5">
        <!-- Total Users Card -->
        <div class="col-md-4">
            <div class="card text-white bg-primary mb-3">
                <div class="card-header">Total Users</div>
                <div class="card-body">
                    <h5 class="card-title">{{ $totalUsers }}</h5>
                    <p class="card-text">Total registered users in the system.</p>
                </div>
            </div>
        </div>

        <!-- Total Orders Card -->
        <div class="col-md-4">
            <div class="card text-white bg-success mb-3">
                <div class="card-header">Total Orders</div>
                <div class="card-body">
                    <h5 class="card-title">{{ $totalOrders }}</h5>
                    <p class="card-text">Total orders processed in the system.</p>
                </div>
            </div>
        </div>

        <!-- Pending Requests Card -->
        <div class="col-md-4">
            <div class="card text-white bg-warning mb-3">
                <div class="card-header">Pending Requests</div>
                <div class="card-body">
                    <h5 class="card-title">{{ $pendingRequests }}</h5>
                    <p class="card-text">Requests waiting for approval.</p>
                </div>
            </div>
        </div>
    </div>

    <!-- Recent Orders Section -->
    <h4 class="mt-5">Recent Orders</h4>
    <table class="table table-striped">
        <thead>
            <tr>
                <th>#</th>
                <th>Order ID</th>
                <th>Customer</th>
                <th>Status</th>
                <th>Date</th>
            </tr>
        </thead>
        <tbody>
            @foreach ($recentOrders as $order)
                <tr>
                    <td>{{ $loop->iteration }}</td>
                    <td>{{ $order->id }}</td>
                    <td>{{ $order->customer_name }}</td>
                    <td>{{ $order->status }}</td>
                    <td>{{ $order->created_at->format('Y-m-d H:i') }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>
@endsection
