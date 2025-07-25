@extends('admin.layouts.app')

@section('content')
<div class="container">
    <h1>Search Results</h1>

    <h3>Users</h3>
    <ul class="list-group">
        @foreach ($users as $user)
            <li class="list-group-item">
                {{ $user->name }} ({{ $user->email }})
            </li>
        @endforeach
    </ul>

    <h3>Orders</h3>
    <ul class="list-group">
        @foreach ($orders as $order)
            <li class="list-group-item">
                Order #{{ $order->order_number }} - Status: {{ $order->status }}
            </li>
        @endforeach
    </ul>

    <h3>Foods</h3>
    <ul class="list-group">
        @foreach ($foods as $food)
            <li class="list-group-item">
                {{ $food->name }} - {{ $food->description }}
            </li>
        @endforeach
    </ul>
</div>
@endsection
