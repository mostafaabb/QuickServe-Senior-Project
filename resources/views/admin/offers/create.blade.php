@extends('admin.layout')

@section('content')
<div class="container mt-5">
    <div class="card shadow rounded">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">Add New Offer</h4>
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

            <form action="{{ route('admin.offers.store') }}" method="POST" enctype="multipart/form-data">
                @csrf

                <div class="mb-3">
                    <label for="restaurant_id" class="form-label">Restaurant</label>
                    <select class="form-control" id="restaurant_id" name="restaurant_id" required>
                        @foreach ($restaurants as $restaurant)
                            <option value="{{ $restaurant->id }}"
                                {{ old('restaurant_id') == $restaurant->id ? 'selected' : '' }}>
                                {{ $restaurant->name }}
                            </option>
                        @endforeach
                    </select>
                </div>

                <div class="mb-3">
                    <label for="title" class="form-label">Offer Title</label>
                    <input type="text" class="form-control" id="title" name="title"
                           value="{{ old('title') }}" required placeholder="Enter offer title">
                </div>

                <div class="mb-3">
                    <label for="description" class="form-label">Description</label>
                    <textarea class="form-control" id="description" name="description"
                              placeholder="Optional description">{{ old('description') }}</textarea>
                </div>

                <div class="mb-3">
                    <label for="discount" class="form-label">Discount Percentage</label>
                    <input type="number" class="form-control" id="discount" name="discount"
                           value="{{ old('discount') }}" step="0.01" min="0" max="100" required
                           placeholder="Enter discount percentage">
                </div>

                <div class="mb-3">
                    <label for="start_date" class="form-label">Start Date</label>
                    <input type="date" class="form-control" id="start_date" name="start_date"
                           value="{{ old('start_date') }}" required>
                </div>

                <div class="mb-3">
                    <label for="end_date" class="form-label">End Date</label>
                    <input type="date" class="form-control" id="end_date" name="end_date"
                           value="{{ old('end_date') }}" required>
                </div>

                <div class="mb-3">
                    <label for="image" class="form-label">Offer Image</label>
                    <input type="file" class="form-control" id="image" name="image" accept="image/*">
                </div>

                <div class="text-end">
                    <a href="{{ route('admin.offers.index') }}" class="btn btn-secondary">← Back</a>
                    <button type="submit" class="btn btn-success">Create Offer</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
