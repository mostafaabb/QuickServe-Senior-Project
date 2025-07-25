<!-- resources/views/admin/users/show.blade.php -->
@extends('layouts.app')

@section('content')
<div class="container">
    <h2>User Details</h2>
    <div class="card">
        <div class="card-header">{{ $user->name }}</div>
        <div class="card-body">
            <p><strong>Email:</strong> {{ $user->email }}</p>
            <a href="{{ route('admin.users.edit', $user->id) }}" class="btn btn-warning">Edit</a>
            <form action="{{ route('admin.users.destroy', $user->id) }}" method="POST" style="display:inline;">
                @csrf
                @method('DELETE')
                <button type="submit" class="btn btn-danger">Delete</button>
            </form>
        </div>
    </div>
</div>
@endsection
