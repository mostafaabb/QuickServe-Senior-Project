@extends('admin.layout')

@section('content')
<div class="container mt-4">
    <div class="card shadow-sm border-0 rounded">
        <div class="card-header bg-warning text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0">🍔 Foods</h4>
            <a href="{{ route('admin.foods.create') }}" class="btn btn-light">
                ➕ Add New Food
            </a>
        </div>

        <div class="card-body">
            @if (session('success'))
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    {{ session('success') }}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            @endif

            <form method="GET" action="{{ route('admin.foods.index') }}" class="mb-3">
    <div class="input-group">
        <input type="text" name="search" value="{{ request('search') }}" class="form-control" placeholder="🔍 Search foods by name...">
        <button class="btn btn-outline-warning" type="submit">Search</button>
    </div>
</form>


            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle">
                    <thead class="bg-warning text-white">
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Price</th>
                            <th>Category</th>
                            <th>Image</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse ($foods as $food)
                            <tr>
                                <td>{{ $food->id }}</td>
                                <td>{{ $food->name }}</td>
                                <td>{{ $food->description ?? 'No description' }}</td>
                                <td>${{ number_format($food->price, 2) }}</td>
                                <td>{{ $food->category->name ?? 'N/A' }}</td>
                                <td>
                                    @if ($food->image)
                                        <img src="{{ asset('storage/' . $food->image) }}" alt="Food Image" width="60" height="60" class="rounded" style="object-fit: cover;">
                                    @else
                                        <span class="text-muted">No Image</span>
                                    @endif
                                </td>
                                <td>
                                    <a href="{{ route('admin.foods.edit', $food->id) }}" class="btn btn-sm btn-warning">✏️</a>
                                    <form action="{{ route('admin.foods.destroy', $food->id) }}" method="POST" class="d-inline" onsubmit="return confirm('Are you sure you want to delete this food?')">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" class="btn btn-sm btn-danger">🗑️</button>
                                    </form>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="7" class="text-center text-muted py-4">No food items found.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
@endsection
