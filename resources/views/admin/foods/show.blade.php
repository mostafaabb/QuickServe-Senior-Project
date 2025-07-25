<!-- resources/views/admin/food/show.blade.php -->
@extends('layouts.app')

@section('content')
<div class="container">
    <h2>Food Details</h2>
    <div class="card">
        <div class="card-header">{{ $food->name }}</div>
        <div class="card-body">
            <p><strong>Price:</strong> ${{ $food->price }}</p>
            <a href="{{ route('admin.foods.edit', $food->id) }}" class="btn btn-warning">Edit</a>
            <form action="{{ route('admin.foods.destroy', $food->id) }}" method="POST" style="display:inline;">
                @csrf
                @method('DELETE')
                <button type="submit" class="btn btn-danger">Delete</button>
            </form>
        </div>
    </div>
</div>
@endsection
