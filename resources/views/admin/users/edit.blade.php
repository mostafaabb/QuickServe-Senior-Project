@extends('admin.layout')

@section('content')
<div class="container-fluid py-4">

    <!-- Page Header -->
    <div class="row mb-4">
        <div class="col-12">
            <h1 class="display-4">🛠️ Edit User</h1>
            <p class="lead">Update the details of this user.</p>
        </div>
    </div>

    <!-- User Edit Form -->
    <div class="row">
        <div class="col-12">
            <div class="card shadow-lg rounded">
                <div class="card-header bg-warning text-white">
                    <h5 class="card-title mb-0">Edit User Information</h5>
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
                    
                    <form action="{{ route('admin.users.update', $user->id) }}" method="POST">
                        @csrf
                        @method('PUT')
                        
                        <div class="mb-3">
                            <label for="name" class="form-label">👤 Name</label>
                            <input type="text" class="form-control" id="name" name="name" value="{{ old('name', $user->name) }}" required placeholder="Enter user's name">
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">📧 Email Address</label>
                            <input type="email" class="form-control" id="email" name="email" value="{{ old('email', $user->email) }}" required placeholder="Enter user's email">
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">🔑 New Password (leave blank to keep current)</label>
                            <input type="password" class="form-control" id="password" name="password" placeholder="Enter new password (optional)" required>
                        </div>

                        <div class="text-end">
                            <a href="{{ route('admin.users.index') }}" class="btn btn-secondary">← Back to Users</a>
                            <button type="submit" class="btn btn-warning">📝 Update User</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

</div>
@endsection
