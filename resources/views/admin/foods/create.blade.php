@extends('admin.layout')

@section('content')
<div class="container mt-5">
    <div class="card shadow rounded">
        <div class="card-header bg-success text-white">
            <h4 class="mb-0">🍽️ Add New Food Item</h4>
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

            <form method="POST" action="{{ route('admin.foods.store') }}" enctype="multipart/form-data">
                @csrf

                <div class="mb-3">
                    <label class="form-label">🍔 Food Name</label>
                    <input type="text" name="name" class="form-control" value="{{ old('name') }}" required placeholder="e.g., Cheeseburger">
                </div>

                <div class="mb-3">
                    <label class="form-label">💵 Price</label>
                    <input type="number" name="price" class="form-control" step="0.01" value="{{ old('price') }}" required placeholder="e.g., 9.99">
                </div>

                <div class="mb-3">
                    <label class="form-label">📂 Category</label>
                    <select name="category_id" class="form-select" required>
                        <option value="">-- Select Category --</option>
                        @foreach($categories as $category)
                            <option value="{{ $category->id }}" {{ old('category_id') == $category->id ? 'selected' : '' }}>
                                {{ $category->name }}
                            </option>
                        @endforeach
                    </select>
                </div>

                <div class="mb-3">
                    <label class="form-label">📝 Description</label>
                    <textarea name="description" class="form-control" rows="3" required placeholder="Enter a brief description">{{ old('description') }}</textarea>
                </div>

                <div class="mb-3">
                    <label class="form-label">📷 Food Image</label>
                    <input type="file" name="image" class="form-control" required>
                </div>

                <div class="text-end">
                    <a href="{{ route('admin.foods.index') }}" class="btn btn-secondary">← Back</a>
                    <button type="submit" class="btn btn-primary">➕ Add Food</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
