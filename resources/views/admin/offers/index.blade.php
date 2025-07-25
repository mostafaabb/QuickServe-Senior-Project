@extends('admin.layout')

@section('content')
<div class="container my-4">
    <div class="card border-0 shadow-sm rounded bg-light">
        <div class="card-header bg-warning text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0">🎁 Offers List</h4>
            <a href="{{ route('admin.offers.create') }}" class="btn btn-light text-warning fw-bold">
                ➕ Add Offer
            </a>
        </div>

        <div class="card-body">
            @if(session('success'))
                <div class="alert alert-success alert-dismissible fade show" role="alert">
                    {{ session('success') }}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            @endif

            <div class="table-responsive">
                <table class="table table-hover align-middle table-bordered">
                    <thead class="bg-warning text-white text-uppercase">
                        <tr>
                            <th>#</th>
                            <th>Restaurant</th>
                            <th>Title</th>
                            <th>Description</th>
                            <th>Discount</th>
                            <th>Start</th>
                            <th>End</th>
                            <th>Image</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($offers as $offer)
                            <tr>
                                <td>{{ $loop->iteration }}</td>
                                <td>{{ $offer->restaurant->name ?? 'N/A' }}</td>
                                <td>{{ $offer->title }}</td>
                                <td>{{ $offer->description }}</td>
                                <td><span class="badge bg-success">{{ $offer->discount }}%</span></td>
                                <td>{{ $offer->start_date }}</td>
                                <td>{{ $offer->end_date }}</td>
                                <td>
                                    @if($offer->image)
                                        <img src="{{ asset('storage/' . $offer->image) }}"
                                             alt="Offer Image"
                                             class="rounded shadow-sm"
                                             style="width: 60px; height: auto; object-fit: cover;">
                                    @else
                                        <span class="text-muted">No Image</span>
                                    @endif
                                </td>
                                <td>
                                    <a href="{{ route('admin.offers.edit', $offer->id) }}"
                                       class="btn btn-sm btn-outline-warning me-1">
                                       ✏️
                                    </a>
                                    <form action="{{ route('admin.offers.destroy', $offer->id) }}"
                                          method="POST"
                                          class="d-inline"
                                          onsubmit="return confirm('Delete this offer?')">
                                        @csrf
                                        @method('DELETE')
                                        <button class="btn btn-sm btn-outline-danger">🗑️</button>
                                    </form>
                                </td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="9" class="text-center text-muted py-4">
                                    No offers found.
                                </td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
@endsection
