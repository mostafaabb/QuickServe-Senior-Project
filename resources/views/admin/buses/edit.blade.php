@extends('admin.layout')

@section('content')
<div class="container mt-5">
    <div class="card shadow rounded">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">✏️ Edit Bus</h4>
        </div>

        <div class="card-body">
            @if ($errors->any())
                <div class="alert alert-danger">
                    <strong>Whoops!</strong> Please fix the following errors:
                    <ul class="mb-0 mt-2">
                        @foreach ($errors->all() as $error)
                            <li>🔸 {{ $error }}</li>
                        @endforeach
                    </ul>
                </div>
            @endif

            <form action="{{ route('admin.buses.update', $bus->id) }}" method="POST">
                @csrf
                @method('PUT')

                <div class="mb-3">
                    <label for="bus_number" class="form-label">Bus Number</label>
                    <input type="text" name="bus_number" id="bus_number" class="form-control" value="{{ old('bus_number', $bus->bus_number) }}" required>
                </div>

                <div class="mb-3">
                    <label for="driver_name" class="form-label">Driver Name</label>
                    <input type="text" name="driver_name" id="driver_name" class="form-control" value="{{ old('driver_name', $bus->driver_name) }}" required>
                </div>

                <div class="mb-3">
                    <label for="capacity" class="form-label">Capacity</label>
                    <input type="number" name="capacity" id="capacity" class="form-control" value="{{ old('capacity', $bus->capacity) }}" required>
                </div>

                <div class="mb-3">
                    <label for="available_seats" class="form-label">Available Seats</label>
                    <input type="number" name="available_seats" id="available_seats" class="form-control" value="{{ old('available_seats', $bus->available_seats) }}" required>
                </div>

                <div class="mb-3">
                    <label for="departure_time" class="form-label">Departure Time</label>
                    <input type="time" name="departure_time" id="departure_time" class="form-control"
                        value="{{ old('departure_time', \Carbon\Carbon::parse($bus->departure_time)->format('H:i')) }}" required>
                </div>

                <div class="mb-3">
                    <label for="arrival_time" class="form-label">Arrival Time</label>
                    <input type="time" name="arrival_time" id="arrival_time" class="form-control"
                        value="{{ old('arrival_time', \Carbon\Carbon::parse($bus->arrival_time)->format('H:i')) }}" required>
                </div>

                <div class="mb-3">
                    <label for="route" class="form-label">Route</label>
                    <input type="text" name="route" id="route" class="form-control" value="{{ old('route', $bus->route) }}" required>
                </div>

                <div class="text-end">
                    <a href="{{ route('admin.buses.index') }}" class="btn btn-secondary">← Back</a>
                    <button type="submit" class="btn btn-success">💾 Update Bus</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
