@extends('admin.layout')

@section('content')
<div class="container-fluid py-4">

    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <h1 class="display-4">🍕 Edit Food Item</h1>
            <p class="lead">Update the details of this food item.</p>
        </div>
    </div>

    <!-- Food Edit Form -->
    <div class="row">
        <div class="col-12">
            <div class="card shadow-lg rounded">
                <div class="card-header bg-primary text-white">
                    <h5 class="card-title mb-0">Edit Food Information</h5>
                </div>
                <div class="card-body">
                    @if ($errors->any())
                        <div class="alert alert-danger">
                            <strong>Whoops!</strong> There were some problems with your input.
                            <ul class="mb-0">
                                @foreach ($errors->all() as $error)
                                    <li>🔸 {{ $error }}</li>
                                @endforeach
                            </ul>
                        </div>
                    @endif
                    
                    <form method="POST" action="{{ route('admin.foods.update', $food->id) }}" enctype="multipart/form-data">
                        @csrf
                        @method('PUT') <!-- Add this to specify it's a PUT request for updating -->
                        
                        <div class="mb-3">
                            <label class="form-label">🍔 Food Name</label>
                            <input type="text" name="name" class="form-control" value="{{ old('name', $food->name) }}" required placeholder="Enter food name">
                        </div>

                        <div class="col-md-12">
                        <label class="form-label">📝 Description</label>
                        <textarea name="description" class="form-control" rows="3" required>{{ old('description', $food->description) }}</textarea>
                    </div>

                        <div class="mb-3">
                            <label class="form-label">💵 Price</label>
                            <input type="number" name="price" class="form-control" value="{{ old('price', $food->price) }}" step="0.01" required placeholder="Enter food price">
                        </div>

                        <div class="mb-3">
                            <label for="category_id" class="form-label">🍴 Category</label>
                            <select class="form-control" id="category_id" name="category_id" required>
                                <option value="">Select a category</option>
                                @foreach($categories as $category)
                                    <option value="{{ $category->id }}" 
                                        @if($category->id == $food->category_id) selected @endif>
                                        {{ $category->name }}
                                    </option>
                                @endforeach
                            </select>
                        </div>

                        <div class="mb-3">
                            <label class="form-label">📸 Image</label>
                            <input type="file" name="image" class="form-control" required>
                            <small class="text-muted">Leave blank to keep the current image.</small>
                        </div>

                        <div class="text-end">
                            <a href="{{ route('admin.foods.index') }}" class="btn btn-secondary">← Back to Food List</a>
                            <button type="submit" class="btn btn-primary">Update Food</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>
@endsection
