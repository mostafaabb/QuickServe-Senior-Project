@extends('admin.layout')

@section('content')
<div class="container-fluid py-4">

    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <h1 class="display-4">🆕 Add New Category</h1>
            <p class="lead">Fill out the form below to add a new food category.</p>
        </div>
    </div>

    <!-- Category Add Form -->
    <div class="row">
        <div class="col-12">
            <div class="card shadow-lg rounded">
                <div class="card-header bg-primary text-white">
                    <h5 class="card-title mb-0">Create a New Category</h5>
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
                    
                    <form action="{{ route('admin.categories.store') }}" method="POST" enctype="multipart/form-data">
                        @csrf

                        <div class="mb-3">
                            <label for="name" class="form-label">📋 Category Name</label>
                            <input type="text" name="name" id="name" class="form-control" required placeholder="Enter category name" value="{{ old('name') }}">
                        </div>

                        <div class="mb-3">
                            <label for="description" class="form-label">📝 Category Description</label>
                            <textarea name="description" id="description" class="form-control" rows="4" required placeholder="Enter a description for the category">{{ old('description') }}</textarea>
                        </div>

                        <div class="mb-3">
                            <label for="image" class="form-label">🖼️ Category Image (optional)</label>
                            <input type="file" name="image" id="image" class="form-control" accept="image/*">
                        </div>

                        <div class="text-end">
                            <a href="{{ route('admin.categories.index') }}" class="btn btn-secondary">← Back to Categories</a>
                            <button type="submit" class="btn btn-primary">Create Category</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>
@endsection
