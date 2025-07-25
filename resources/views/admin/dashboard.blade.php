@extends('admin.layout')

@section('content')
<div class="container py-4">
    <h2 class="mb-4">📊Admin Dashboard</h2>

    <!-- Search Bar -->
    <div class="mb-4">
    <h3>Welcome to the Admin Dashboard!</h3>
    <p>We're happy to have you here. Manage your food delivery orders, users, and more.</p>
</div>


    <!-- Statistics Cards -->
    <div class="row text-white mb-4">
        <div class="col-md-3 mb-3">
            <div class="card bg-primary shadow rounded">
                <div class="card-body">
                    <h5>Total Users</h5>
                    <h3>{{ $totalUsers ?? 0 }}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card bg-success shadow rounded">
                <div class="card-body">
                    <h5>Total Orders</h5>
                    <h3>{{ $totalOrders ?? 0 }}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card bg-warning shadow rounded">
                <div class="card-body">
                    <h5>Pending Orders</h5>
                    <h3>{{ $pendingOrders ?? 0 }}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card bg-danger shadow rounded">
                <div class="card-body">
                    <h5>Revenue</h5>
                    <h3>${{ $totalRevenue ?? 0 }}</h3>
                </div>
            </div>
        </div>
    </div>

    <!-- Chart Section -->
    <div class="card shadow mb-4">
        <div class="card-body">
            <h5 class="card-title">Orders Over Time</h5>
            <canvas id="ordersChart" height="100"></canvas>
        </div>
    </div>
</div>


<!-- Chart.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function() {
    const ctx = document.getElementById('ordersChart').getContext('2d');
    const ordersChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: {!! json_encode($chartLabels ?? []) !!},
            datasets: [{
                label: 'Orders',
                data: {!! json_encode($chartData ?? []) !!},
                borderColor: 'rgba(75, 192, 192, 1)',
                backgroundColor: 'rgba(75, 192, 192, 0.2)',
                fill: true,
                tension: 0.4
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });
});
</script>
@endsection
