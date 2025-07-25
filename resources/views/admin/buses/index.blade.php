@extends('admin.layout')

@section('content')
<div class="container-fluid py-4">
    <div class="card shadow-sm border-0 rounded">
        <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
            <h4 class="mb-0">🚌 All Buses</h4>
             <form action="{{ route('admin.buses.index') }}" method="GET" class="d-flex gap-2">
                    <input type="text" name="search" value="{{ request('search') }}" class="form-control form-control-sm" placeholder="🔍 Search bus number, driver, route...">
                    <button type="submit" class="btn btn-outline-light btn-sm fw-bold">Search</button>
                </form>
            
            <a href="{{ route('admin.buses.booked') }}" class="btn btn-light text-dark me-2">
            🗓️ View Booked Buses
        </a>
            <a href="{{ route('admin.buses.create') }}" class="btn btn-light text-dark">
                ➕ Add New Bus
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
                            <th>Bus Number</th>
                            <th>Driver</th>
                            <th>Capacity</th>
                            <th>Available Seats</th>
                            <th>Departure</th>
                            <th>Arrival</th>
                            <th>Route</th>
                            <th class="text-center">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($buses as $bus)
                        <tr>
                            <td>{{ $bus->id }}</td>
                            <td>{{ $bus->bus_number }}</td>
                            <td>{{ $bus->driver_name }}</td>
                            <td>{{ $bus->capacity }}</td>
                            <td>{{ $bus->available_seats }}</td>
                            <td>{{ \Carbon\Carbon::parse($bus->departure_time)->format('H:i') }}</td>
                            <td>{{ \Carbon\Carbon::parse($bus->arrival_time)->format('H:i') }}</td>
                            <td>{{ $bus->route }}</td>
                            <td class="text-center">
                                <a href="{{ route('admin.buses.edit', $bus->id) }}" class="btn btn-sm btn-warning me-1">✏️</a>
                                <form action="{{ route('admin.buses.destroy', $bus->id) }}" method="POST" class="d-inline" onsubmit="return confirm('Are you sure you want to delete this bus?')">
                                    @csrf
                                    @method('DELETE')
                                    <button class="btn btn-sm btn-danger">🗑️</button>
                                </form>
                            </td>
                        </tr>
                        @empty
                        <tr>
                            <td colspan="9" class="text-center text-muted py-4">No buses found.</td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>

            {{-- Pagination if applicable --}}
            @if(method_exists($buses, 'links'))
                <div class="d-flex justify-content-center mt-3">
                    {{ $buses->links() }}
                </div>
            @endif
        </div>
    </div>
</div>
@endsection
