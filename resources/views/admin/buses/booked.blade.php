@extends('admin.layout')

@section('content')
<div class="container-fluid py-4">
    <div class="card shadow-sm border-0 rounded">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0">🚌 Booked Buses</h4>
            <a href="{{ route('admin.buses.index') }}" class="btn btn-light text-dark me-2">
                🔙 Back to All Buses
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
                            <th>Booking ID</th>
                            <th>User</th>
                            <th>Bus Number</th>
                            <th>Route</th>
                            <th>Seats Booked</th>
                            <th>Booking Time</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($bookedBuses as $bus)
                        <tr>
                            <td>{{ $bus->id }}</td>
                            <td>{{ $bus->user_name }}</td>
                            <td>{{ $bus->bus_number }}</td>
                            <td>{{ $bus->route }}</td>
                            <td>{{ $bus->seats_booked }}</td>
                            <td>{{ \Carbon\Carbon::parse($bus->created_at)->format('Y-m-d H:i') }}</td>
                        </tr>
                        @empty
                        <tr>
                            <td colspan="6" class="text-center text-muted py-4">No booked buses found.</td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>

            {{-- Optional pagination --}}
            @if(method_exists($bookedBuses, 'links'))
                <div class="d-flex justify-content-center mt-3">
                    {{ $bookedBuses->links() }}
                </div>
            @endif
        </div>
    </div>
</div>
@endsection
