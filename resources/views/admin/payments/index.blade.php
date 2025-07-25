@extends('admin.layout')

@section('content')
<div class="container py-4">
    <h2 class="mb-4">Payment History</h2>

    <table class="table table-striped">
        <thead>
            <tr>
                <th scope="col">Payment ID</th>
                <th scope="col">Order ID</th>
                <th scope="col">User</th>
                <th scope="col">Amount</th>
                <th scope="col">Status</th>
                <th scope="col">Date</th>
            </tr>
        </thead>
        <tbody>
            @foreach($payments as $payment)
                <tr>
                    <td>{{ $payment->id }}</td>
                    <td>{{ $payment->order->id }}</td>
                    <td>{{ $payment->user->name }}</td>
                    <td>${{ $payment->amount }}</td>
                    <td>{{ ucfirst($payment->status) }}</td>
                    <td>{{ $payment->created_at->format('Y-m-d H:i') }}</td>
                </tr>
            @endforeach
        </tbody>
    </table>

    <!-- Pagination Links -->
    {{ $payments->links() }}
</div>
@endsection
