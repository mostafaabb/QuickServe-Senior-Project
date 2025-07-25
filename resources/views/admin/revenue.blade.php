@extends('admin.layout')

@section('content')
    <h1>💰 Revenue Overview</h1>

    <!-- Revenue Cards -->
    <div class="row text-white mb-4">
        <div class="col-md-3 mb-3">
            <div class="card bg-primary shadow rounded">
                <div class="card-body">
                    <h5>Total Revenue</h5>
                    <h3>${{ number_format($totalRevenue ?? 0, 2) }}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card bg-success shadow rounded">
                <div class="card-body">
                    <h5>Monthly Revenue</h5>
                    <h3>${{ number_format($monthlyRevenue ?? 0, 2) }}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card bg-warning shadow rounded">
                <div class="card-body">
                    <h5>Pending Payments</h5>
                    <h3>${{ number_format($pendingRevenue ?? 0, 2) }}</h3>
                </div>
            </div>
        </div>
        <div class="col-md-3 mb-3">
            <div class="card bg-danger shadow rounded">
                <div class="card-body">
                    <h5>Refunds</h5>
                    <h3>${{ number_format($totalRefunds ?? 0, 2) }}</h3>
                </div>
            </div>
        </div>
    </div>

    <!-- Chart Section for Revenue Trends -->
    <div class="card shadow mb-4">
        <div class="card-body">
            <h5 class="card-title">Revenue Over Time</h5>
            <canvas id="revenueChart" height="100"></canvas>
        </div>
    </div>
@endsection

<!-- Chart.js CDN -->
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>

<script>
document.addEventListener("DOMContentLoaded", function() {
    const ctx = document.getElementById('revenueChart').getContext('2d');
    const revenueChart = new Chart(ctx, {
        type: 'line',
        data: {
            labels: {!! json_encode($chartLabels ?? []) !!},
            datasets: [{
                label: 'Revenue',
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
