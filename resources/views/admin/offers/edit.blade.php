@extends('admin.layout')

@section('content')
<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-warning text-dark">
            <h4>✏️ Edit Offer</h4>
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

            <form action="{{ route('admin.offers.update', $offer->id) }}" method="POST" enctype="multipart/form-data">
                @csrf
                @method('PUT')

                <div class="mb-3">
                    <label>Restaurant</label>
                    <select name="restaurant_id" class="form-select" required>
                        @foreach($restaurants as $restaurant)
                            <option value="{{ $restaurant->id }}"
                                {{ old('restaurant_id', $offer->restaurant_id) == $restaurant->id ? 'selected' : '' }}>
                                {{ $restaurant->name }}
                            </option>
                        @endforeach
                    </select>
                </div>

                <div class="mb-3">
                    <label>Title</label>
                    <input type="text" name="title" class="form-control"
                           value="{{ old('title', $offer->title) }}" required>
                </div>

                <div class="mb-3">
                    <label>Description</label>
                    <textarea name="description" class="form-control" rows="3"
                              placeholder="Optional description">{{ old('description', $offer->description) }}</textarea>
                </div>

                <div class="mb-3">
                    <label>Discount Percentage</label>
                    <input type="number" name="discount" class="form-control"
                           value="{{ old('discount', $offer->discount) }}" step="0.01" min="0" max="100" required>
                </div>

                <div class="mb-3">
                    <label>Start Date</label>
                    <input type="date" name="start_date" class="form-control"
                           value="{{ old('start_date', $offer->start_date) }}" required>
                </div>

                <div class="mb-3">
                    <label>End Date</label>
                    <input type="date" name="end_date" class="form-control"
                           value="{{ old('end_date', $offer->end_date) }}" required>
                </div>

                <div class="mb-3">
                    <label>Offer Image</label>
                    <input type="file" name="image" class="form-control" accept="image/*">
                </div>

                @if($offer->image)
                    <div class="mb-3">
                        <label>Current Image:</label><br>
                        <img src="{{ asset('storage/' . $offer->image) }}" alt="Offer Image" style="max-width: 150px; height: auto; border-radius: 4px;">
                    </div>
                @endif

                <div class="text-end">
                    <a href="{{ route('admin.offers.index') }}" class="btn btn-secondary">← Back</a>
                    <button class="btn btn-warning">💾 Update</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
