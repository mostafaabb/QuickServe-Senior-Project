@extends('admin.layout')

@section('content')
<div class="container my-4">
    <div class="card border-0 shadow-sm rounded bg-light">
        <div class="card-header bg-success text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0">🌳 Picnic Places</h4>
            
            <a href="{{ route('admin.picnic_places.create') }}" class="btn btn-light text-success fw-bold">
                ➕ Add Place
            </a>
        </div>

        <div class="card-body">
            @if(session('success'))
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    {{ session('success') }}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            @endif
<div class="mb-3">
                <form action="{{ route('admin.picnic_places.index') }}" method="GET" class="d-flex gap-2 flex-wrap">
                    <input type="text" name="search" value="{{ request('search') }}"
                           class="form-control form-control-sm"
                           placeholder="🔍 Search name, location...">
                    <button type="submit" class="btn btn-outline-success btn-sm fw-bold">Search</button>
                </form>
            </div>
            

            <div class="table-responsive">
                <table class="table table-hover align-middle table-bordered">
                   <thead class="bg-success text-white text-uppercase">
    <tr>
        <th>#</th>
        <th>Name</th>
        <th>Location</th>
        <th>Description</th>
        <th>Image</th>
        <th>Actions</th>
    </tr>
</thead>
<tbody>
    @forelse($places as $place)
        <tr>
            <td>{{ $loop->iteration }}</td>
            <td>{{ $place->name }}</td>
            <td>{{ $place->location }}</td>
            <td>{{ $place->description }}</td> 
            <td>
                @if($place->image)
                    <img src="{{ asset('storage/' . $place->image) }}"
                         alt="Place Image"
                         class="rounded shadow-sm"
                         style="width: 60px; height: auto; object-fit: cover;">
                @else
                    <span class="text-muted">No Image</span>
                @endif
            </td>
            <td>
                <a href="{{ route('admin.picnic_places.edit', $place->id) }}"
                   class="btn btn-sm btn-outline-success me-1">
                   ✏️
                </a>
                <form action="{{ route('admin.picnic_places.destroy', $place->id) }}"
                      method="POST"
                      class="d-inline"
                      onsubmit="return confirm('Delete this place?')">
                    @csrf
                    @method('DELETE')
                    <button class="btn btn-sm btn-outline-danger">🗑️</button>
                </form>
            </td>
        </tr>
    @empty
        <tr>
            <td colspan="6" class="text-center text-muted py-4">
                No picnic places found.
            </td>
        </tr>
    @endforelse
</tbody>
                </table>
            </div>
        </div>
    </div>

    <div class="mt-3">
        {{ $places->links() }}
    </div>
</div>
@endsection
