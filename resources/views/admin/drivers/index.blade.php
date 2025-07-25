@extends('admin.layout')

@section('content')
<div class="container-fluid mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4 flex-wrap gap-2">
        <h4 class="text-uppercase fw-bold">🚗Drivers</h4>
         <form action="{{ route('admin.drivers.index') }}" method="GET" class="d-flex flex-wrap gap-2">
        <input type="text" name="search" value="{{ request('search') }}" class="form-control form-control-sm" placeholder="🔍 Search name, email, phone...">
        <button type="submit" class="btn btn-outline-primary btn-sm fw-bold">Search</button>
    </form>
        <div class="d-flex gap-2 flex-wrap">
            <a href="{{ route('admin.drivers.create') }}" class="btn btn-success fw-semibold px-4">
                ➕ Add Driver
            </a>
            <a href="{{ route('admin.drivers.booked') }}" class="btn btn-outline-warning fw-bold px-4">
                📋 View Booked Drivers
            </a>
        </div>
    </div>

    @if(session('success'))
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            {{ session('success') }}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    @endif

    <div class="table-responsive shadow-sm border rounded">
        <table class="table table-hover align-middle mb-0">
            <thead class="bg-warning text-white text-uppercase">
                <tr>
                    <th>ID</th>  {{-- Added ID column --}}
                    <th>Name</th>
                    <th>Phone</th>
                    <th>Email</th>
                    <th>Vehicle Type</th>
                    <th>Vehicle Number</th>
                    <th>Status</th>
                    <th class="text-center">Actions</th>
                </tr>
            </thead>
            <tbody>
                @forelse($drivers as $driver)
                <tr>
                    <td>{{ $driver->id }}</td> {{-- Display driver ID --}}
                    <td>{{ $driver->name }}</td>
                    <td>{{ $driver->phone }}</td>
                    <td>{{ $driver->email }}</td>
                    <td>{{ $driver->vehicle_type }}</td>
                    <td>{{ $driver->vehicle_number }}</td>
                    <td>
                        <span class="badge 
                            @if($driver->status === 'active') bg-success
                            @elseif($driver->status === 'pending') bg-warning text-dark
                            @elseif($driver->status === 'inactive') bg-secondary
                            @else bg-info
                            @endif
                        ">
                            {{ ucfirst($driver->status) }}
                        </span>
                    </td>
                    <td class="text-center">
                        <a href="{{ route('admin.drivers.edit', $driver->id) }}" class="btn btn-sm btn-primary me-1" title="Edit Driver">
                            ✏️
                        </a>

                        <form action="{{ route('admin.drivers.destroy', $driver->id) }}" method="POST" class="d-inline-block" onsubmit="return confirm('Are you sure you want to delete this driver?');">
                            @csrf
                            @method('DELETE')
                            <button type="submit" class="btn btn-sm btn-danger" title="Delete Driver">
                                🗑️
                            </button>
                        </form>
                    </td>
                </tr>
                @empty
                <tr>
                    <td colspan="8" class="text-center text-muted py-4">No drivers found.</td>
                </tr>
                @endforelse
            </tbody>
        </table>
    </div>
</div>
@endsection
