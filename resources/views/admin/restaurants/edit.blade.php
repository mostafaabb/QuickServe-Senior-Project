@extends('admin.layout')

@section('content')
<div class="container mt-5">
    <div class="card shadow rounded">
        <div class="card-header bg-warning text-white">
            <h4 class="mb-0">✏️ Edit Restaurant</h4>
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

            <form action="{{ route('admin.restaurants.update', $restaurant->id) }}" method="POST" enctype="multipart/form-data">
                @csrf
                @method('PUT')

                <div class="mb-3">
                    <label for="name" class="form-label">🏷️ Name</label>
                    <input type="text" name="name" class="form-control" id="name" value="{{ $restaurant->name }}" required>
                </div>

                <div class="mb-3">
                    <label for="location" class="form-label">📍 Location</label>
                    <input type="text" name="location" class="form-control" id="location" value="{{ $restaurant->location }}" required>
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">📝 Description</label>
                    <textarea name="description" class="form-control" id="description" rows="3" required>{{ $restaurant->description }}</textarea>
                </div>

                <div class="mb-3">
                    <label for="contact" class="form-label">📞 Contact</label>
                    <input type="text" name="contact" class="form-control" id="contact" value="{{ $restaurant->contact }}" required>
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">📧 Email</label>
                    <input type="email" name="email" class="form-control" id="email" value="{{ $restaurant->email }}" required>
                </div>

                <div class="mb-3">
                    <label for="image" class="form-label">🖼️ Image</label>
                    <input type="file" name="image" class="form-control" id="image" required>
                </div>

                <div class="mb-3">
                    <label for="hours" class="form-label">⏰ Opening Hours</label>
                    <input type="text" name="hours" class="form-control" id="hours" value="{{ $restaurant->hours }}" required>
                </div>

                <div class="text-end">
                    <a href="{{ route('admin.restaurants.index') }}" class="btn btn-secondary">← Back</a>
                    <button type="submit" class="btn btn-warning text-white">🔄 Update Restaurant</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
