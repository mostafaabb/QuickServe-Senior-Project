@extends('admin.layout')

@section('content')
<div class="container mt-5">
    <div class="card shadow rounded">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0">🍴 Restaurants</h4>
            <a href="{{ route('admin.restaurants.create') }}" class="btn btn-success">➕ Add New Restaurant</a>
        </div>

        <div class="card-body">
            @if(session('success'))
                <div class="alert alert-success">{{ session('success') }}</div>
            @endif

            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>#</th>
                        <th>Name</th>
                        <th>Location</th>
                        <th>Description</th>
                        <th>Email</th>
                        <th>Contact</th>
                        <th>Opening Hours</th>
                        <th>Image</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($restaurants as $restaurant)
                        <tr>
                            <td>{{ $restaurant->id }}</td>
                            <td>{{ $restaurant->name }}</td>
                            <td>{{ $restaurant->location }}</td>
                            <td>{{ Str::limit($restaurant->description, 50) }}</td>
                            <td>{{ $restaurant->email }}</td>
                            <td>{{ $restaurant->contact }}</td>
                            <td>{{ $restaurant->hours }}</td>
                            <td>
                                @if($restaurant->image)
                                    <img src="{{ asset('storage/' . $restaurant->image) }}" alt="Image" width="60" height="60" class="rounded">
                                @else
                                    N/A
                                @endif
                            </td>
                            <td>
                                <a href="{{ route('admin.restaurants.edit', $restaurant->id) }}" class="btn btn-warning btn-sm">✏️</a>
                                <form action="{{ route('admin.restaurants.destroy', $restaurant->id) }}" method="POST" class="d-inline" onsubmit="return confirm('Delete this restaurant?')">
                                    @csrf
                                    @method('DELETE')
                                    <button type="submit" class="btn btn-danger btn-sm">🗑️</button>
                                </form>
                            </td>
                        </tr>
                    @endforeach
                </tbody>
            </table>

            {{ $restaurants->links() }} <!-- Pagination links -->
        </div>
    </div>
</div>
@endsection
