@extends('admin.layout')

@section('content')
<div class="container-fluid py-4">
    <div class="card shadow-sm border-0 rounded">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0">🚗 Booked Driver Requests</h4>
            <a href="{{ route('admin.drivers.index') }}" class="btn btn-light text-dark me-2">
                🔙 Back to All Drivers
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
                <table class="table table-bordered table-hover align-middle">
                    <thead class="bg-primary text-white">
                        <tr>
                            <th>ID</th>
                            <th>User</th>
                            <th>Driver</th>
                            <th>Description</th>
                            <th>Pickup Location</th>
                            <th>Dropoff Location</th>
                            <th>Status</th>
                            <th>Created At</th>
                            <th>Updated At</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($bookedRequests as $request)
                        <tr>
                            <td>{{ $request->id }}</td>
                            <td>{{ $request->user ? $request->user->name : 'N/A' }}</td>
                            <td>{{ $request->driver ? $request->driver->name : 'N/A' }}</td>
                            <td>{{ $request->description }}</td>
                            <td>{{ $request->pickup_location }}</td>
                            <td>{{ $request->dropoff_location }}</td>
                            <td>{{ ucfirst($request->status) }}</td>
                            <td>{{ $request->created_at->format('Y-m-d H:i') }}</td>
                            <td>{{ $request->updated_at->format('Y-m-d H:i') }}</td>
                        </tr>
                        @empty
                        <tr>
                            <td colspan="9" class="text-center text-muted py-4">No booked requests found.</td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>

            @if(method_exists($bookedRequests, 'links'))
                <div class="d-flex justify-content-center mt-3">
                    {{ $bookedRequests->links() }}
                </div>
            @endif
        </div>
    </div>
</div>
@endsection
