@extends('admin.layout')

@section('content')
<div class="container mt-5">
    <div class="card shadow rounded">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">🍽️ Add New Restaurant</h4>
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

            <form action="{{ route('admin.restaurants.store') }}" method="POST" enctype="multipart/form-data">
                @csrf

                <div class="mb-3">
                    <label for="name" class="form-label">🏷️ Name</label>
                    <input type="text" name="name" class="form-control" id="name" value="{{ old('name') }}" required placeholder="Enter restaurant name">
                </div>

                <div class="mb-3">
                    <label for="location" class="form-label">📍 Location</label>
                    <input type="text" name="location" class="form-control" id="location" value="{{ old('location') }}" required placeholder="Enter location">
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">📝 Description</label>
                    <textarea name="description" class="form-control" id="description" rows="3" placeholder="Optional description">{{ old('description') }}</textarea>
                </div>

                <div class="mb-3">
                    <label for="contact" class="form-label">📞 Contact</label>
                    <input type="text" name="contact" class="form-control" id="contact" value="{{ old('contact') }}" placeholder="Phone or contact info">
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">📧 Email</label>
                    <input type="email" name="email" class="form-control" id="email" value="{{ old('email') }}" placeholder="Email address">
                </div>

                <div class="mb-3">
                    <label for="image" class="form-label">🖼️ Image</label>
                    <input type="file" name="image" class="form-control" id="image">
                </div>

                <div class="mb-3">
                    <label for="hours" class="form-label">⏰ Opening Hours</label>
                    <input type="text" name="hours" class="form-control" id="hours" value="{{ old('hours') }}" placeholder="e.g. 9AM - 10PM">
                </div>

                <div class="text-end">
                    <a href="{{ route('admin.restaurants.index') }}" class="btn btn-secondary">← Back</a>
                    <button type="submit" class="btn btn-success">💾 Add Restaurant</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
