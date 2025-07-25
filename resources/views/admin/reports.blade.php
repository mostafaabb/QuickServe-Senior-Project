@extends('admin.layout')

@section('content')
<div class="container py-4">
    <h2>📊Reports</h2>

    <div class="row g-4 mb-4">
        <div class="col-md-3">
            <div class="card p-3 text-white bg-success">Total Revenue: ${{ $totalRevenue }}</div>
        </div>
        <div class="col-md-3">
            <div class="card p-3 text-white bg-primary">Total Orders: {{ $totalOrders }}</div>
        </div>
        <div class="col-md-3">
            <div class="card p-3 text-white bg-info">Total Users: {{ $totalUsers }}</div>
        </div>
        <div class="col-md-3">
            <div class="card p-3 text-white bg-warning">Top Food: {{ $topFood->name ?? 'N/A' }}</div>
        </div>
    </div>

    <div class="card p-4">
        <h4>Sales Chart</h4>
        <canvas id="salesChart"></canvas>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
const ctx = document.getElementById('salesChart');
new Chart(ctx, {
    type: 'bar',
    data: {
        labels: @json($chartLabels),
        datasets: [{
            label: 'Monthly Revenue',
            data: @json($chartData),
            backgroundColor: 'rgba(54, 162, 235, 0.7)'
        }]
    },
});
</script>
@endsection
