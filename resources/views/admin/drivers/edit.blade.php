@extends('admin.layout')

@section('content')
<div class="container my-4">
    <div class="card shadow-sm border-0 rounded">
        <div class="card-header bg-primary text-white">
            <h5 class="mb-0">✏️ Edit Driver</h5>
        </div>

        <div class="card-body">
            <form action="{{ route('admin.drivers.update', $driver->id) }}" method="POST">
                @csrf
                @method('PUT')

                <div class="mb-3">
                    <label for="name" class="form-label">Driver Name</label>
                    <input type="text" name="name" id="name" value="{{ old('name', $driver->name) }}" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="phone" class="form-label">Phone</label>
                    <input type="text" name="phone" id="phone" value="{{ old('phone', $driver->phone) }}" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input type="email" name="email" id="email" value="{{ old('email', $driver->email) }}" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="vehicle_type" class="form-label">Vehicle Type</label>
                    <input type="text" name="vehicle_type" id="vehicle_type" value="{{ old('vehicle_type', $driver->vehicle_type) }}" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="vehicle_number" class="form-label">Vehicle Number</label>
                    <input type="text" name="vehicle_number" id="vehicle_number" value="{{ old('vehicle_number', $driver->vehicle_number) }}" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="status" class="form-label">Status</label>
                    <select name="status" id="status" class="form-select" required>
                        <option value="available">Available</option>
                        <option value="booked">Booked</option>
                    </select>
                </div>

                <div class="text-end">
                    <button type="submit" class="btn btn-primary fw-bold">Update Driver 💾</button>
                    <a href="{{ route('admin.drivers.index') }}" class="btn btn-secondary">Cancel</a>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
