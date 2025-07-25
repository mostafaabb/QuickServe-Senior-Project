@extends('admin.layout')

@section('content')
<div class="container-fluid py-4">

    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <h1 class="display-4">✏️ Edit Category</h1>
            <p class="lead">Make changes to the category details below.</p>
        </div>
    </div>

    <!-- Category Edit Form -->
    <div class="row">
        <div class="col-12">
            <div class="card shadow-lg rounded">
                <div class="card-header bg-warning text-white">
                    <h5 class="card-title mb-0">Edit Category Information</h5>
                </div>
                <div class="card-body">
                    @if ($errors->any())
                        <div class="alert alert-danger">
                            <strong>Whoops!</strong> There were some issues with your submission.
                            <ul class="mb-0">
                                @foreach ($errors->all() as $error)
                                    <li>🔸 {{ $error }}</li>
                                @endforeach
                            </ul>
                        </div>
                    @endif

                    <form action="{{ route('admin.categories.update', $category->id) }}" method="POST" enctype="multipart/form-data">
                        @csrf
                        @method('PUT')

                        <div class="mb-3">
                            <label for="name" class="form-label">📋 Category Name</label>
                            <input type="text" name="name" id="name" class="form-control" required value="{{ old('name', $category->name) }}">
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label">📝 Category Description</label>
                            <textarea name="description" id="description" class="form-control" rows="4" required>{{ old('description', $category->description) }}</textarea>
                        </div>

                        <div class="mb-3">
                            <label for="image" class="form-label">🖼️ Category Image (optional)</label>
                            <input type="file" name="image" id="image" class="form-control" accept="image/*">
                        </div>

                        @if($category->image)
                            <div class="mb-3">
                                <p>Current Image:</p>
                                <img src="{{ asset('storage/' . $category->image) }}" alt="{{ $category->name }}" style="max-width: 150px; max-height: 150px; border-radius: 6px;">
                            </div>
                        @endif

                        <div class="text-end">
                            <a href="{{ route('admin.categories.index') }}" class="btn btn-secondary">← Back to Categories</a>
                            <button type="submit" class="btn btn-warning">Update Category</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>
@endsection
