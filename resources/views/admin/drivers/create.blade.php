@extends('admin.layout')

@section('content')
<div class="container mt-5">
    <div class="card shadow rounded">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">➕ Add New Driver</h4>
        </div>

        <div class="card-body">
            <form method="POST" action="{{ route('admin.drivers.store') }}">
                @csrf

                <div class="mb-3">
                    <label for="name" class="form-label">Name</label>
                    <input name="name" id="name" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="phone" class="form-label">Phone</label>
                    <input name="phone" id="phone" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">Email</label>
                    <input name="email" id="email" type="email" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="vehicle_type" class="form-label">Vehicle Type</label>
                    <input name="vehicle_type" id="vehicle_type" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="vehicle_number" class="form-label">Vehicle Number</label>
                    <input name="vehicle_number" id="vehicle_number" class="form-control" required>
                </div>

                <div class="mb-3">
                    <label for="status" class="form-label">Status</label>
                    <select name="status" id="status" class="form-select" required>
                        <option value="available">Available</option>
                        <option value="booked">Booked</option>
                    </select>
                </div>

                <button type="submit" class="btn btn-success">Add Driver</button>
                <a href="{{ route('admin.drivers.index') }}" class="btn btn-secondary ms-2">Cancel</a>
            </form>
        </div>
    </div>
</div>
@endsection
