@extends('admin.layout')

@section('content')
<div class="container mt-5">
    <div class="card shadow rounded">
        <div class="card-header bg-primary text-white">
            <h4 class="mb-0">➕ Add New User</h4>
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

            <form action="{{ route('admin.users.store') }}" method="POST">
                @csrf

                <div class="mb-3">
                    <label for="name" class="form-label">👤 Name</label>
                    <input type="text" name="name" class="form-control" id="name" value="{{ old('name') }}" required placeholder="Enter full name">
                </div>

                <div class="mb-3">
                    <label for="email" class="form-label">📧 Email</label>
                    <input type="email" name="email" class="form-control" id="email" value="{{ old('email') }}" required placeholder="Enter email address">
                </div>

                <div class="mb-3">
                    <label for="password" class="form-label">🔒 Password</label>
                    <input type="password" name="password" class="form-control" id="password" required placeholder="Enter a secure password">
                </div>

                <div class="text-end">
                    <a href="{{ route('admin.users.index') }}" class="btn btn-secondary">← Back</a>
                    <button type="submit" class="btn btn-success">💾 Create User</button>
                </div>
            </form>
        </div>
    </div>
</div>
@endsection
