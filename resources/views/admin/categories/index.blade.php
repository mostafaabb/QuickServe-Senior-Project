@extends('admin.layout')

@section('content')
<div class="container-fluid py-4">
    <div class="card shadow-sm border-0 rounded">
        <div class="card-header bg-warning text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0">📂 Categories</h4>
            <a href="{{ route('admin.categories.create') }}" class="btn btn-light text-dark">➕ Add New Category</a>
        </div>
        <form action="{{ route('admin.categories.index') }}" method="GET" class="d-flex" style="gap: 10px;">
        <input type="text" name="search" value="{{ request('search') }}" class="form-control form-control-sm" placeholder="🔍 Search by name or description...">
        <button type="submit" class="btn btn-light btn-sm">Search</button>
    </form>

        <div class="card-body">
            @if (session('success'))
                <div class="alert alert-success">{{ session('success') }}</div>
            @endif

            <div class="table-responsive">
                <table class="table table-bordered table-hover align-middle">
                    <thead class="bg-warning text-white">
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Description</th>
                            <th>Image</th>
                            <th style="width: 140px;">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse ($categories as $category)
                            <tr>
                                <td>{{ $category->id }}</td>
                                <td>{{ $category->name }}</td>
                                <td>{{ $category->description ?? 'No description available' }}</td>
                                <td>
                                    @if ($category->image)
                                        <img src="{{ asset('storage/' . $category->image) }}" alt="{{ $category->name }}"
                                             style="width: 70px; height: 70px; object-fit: cover; border-radius: 6px;">
                                    @else
                                        <span class="text-muted">No image</span>
                                    @endif
                                </td>
                                <td>
                                    <a href="{{ route('admin.categories.edit', $category->id) }}"
                                       class="btn btn-warning btn-sm me-1">✏️</a>
                                    <form action="{{ route('admin.categories.destroy', $category->id) }}" method="POST"
                                          class="d-inline"
                                          onsubmit="return confirm('Are you sure you want to delete this category?')">
                                        @csrf
                                        @method('DELETE')
                                        <button type="submit" class="btn btn-danger btn-sm">🗑️</button>
                                    </form>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="5" class="text-center text-muted py-4">No categories found.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>

            {{-- Pagination --}}
            <div class="d-flex justify-content-center mt-3">
                {{ $categories->links() }}
            </div>
        </div>
    </div>
</div>
@endsection
