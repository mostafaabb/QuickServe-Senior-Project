@extends('admin.layout')

@section('content')
<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-warning text-dark">
            <h4>✏️ Edit Picnic Place</h4>
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

            <form action="{{ route('admin.picnic_places.update', $picnicPlace->id) }}" method="POST" enctype="multipart/form-data">
                @csrf
                @method('PUT')

                <div class="mb-3">
                    <label>Name *</label>
                    <input type="text" name="name" class="form-control" value="{{ old('name', $picnicPlace->name) }}" required>
                </div>

                <div class="mb-3">
                    <label>Location *</label>
                    <input type="text" name="location" class="form-control" value="{{ old('location', $picnicPlace->location) }}" required>
                </div>

                <div class="mb-3">
                    <label>Description</label>
                    <textarea name="description" class="form-control" rows="3" placeholder="Optional description">{{ old('description', $picnicPlace->description) }}</textarea>
                </div>

                <div class="mb-3">
                    <label>Change Image</label>
                    <input type="file" name="image" class="form-control" accept="image/*">
                </div>

                @if($picnicPlace->image)
                    <div class="mb-3">
                        <label>Current Image:</label><br>
                        <img src="{{ asset('storage/' . $picnicPlace->image) }}" alt="Picnic Place Image" style="max-width: 150px; height: auto; border-radius: 4px;">
                    </div>
                @else
                    <div class="mb-3 text-muted fst-italic">
                        No image uploaded.
                    </div>
                @endif

                <div class="text-end">
                    <a href="{{ route('admin.picnic_places.index') }}" class="btn btn-secondary">← Back</a>
                    <button class="btn btn-warning">💾 Update</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
