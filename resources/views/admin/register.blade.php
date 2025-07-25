<!-- resources/views/admin/register.blade.php -->
@extends('layouts.app')

@section('content')
<div class="container-fluid bg-orange min-vh-100">
    <div class="row justify-content-center align-items-center" style="height: 100vh;">
        <div class="col-md-6 col-lg-4">
            <div class="card shadow-lg">
                <div class="card-body">
                    <h2 class="text-center mb-4">Register New Admin</h2>
                    <form method="POST" action="{{ route('admin.register.submit') }}">
                        @csrf
                        <div class="mb-3">
                            <label for="name" class="form-label">Name</label>
                            <input type="text" id="name" class="form-control" name="name" value="{{ old('name') }}" required>
                            @error('name')
                                <div class="alert alert-danger mt-2">{{ $message }}</div>
                            @enderror
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email Address</label>
                            <input type="email" id="email" class="form-control" name="email" value="{{ old('email') }}" required>
                            @error('email')
                                <div class="alert alert-danger mt-2">{{ $message }}</div>
                            @enderror
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input type="password" id="password" class="form-control" name="password" required>
                            @error('password')
                                <div class="alert alert-danger mt-2">{{ $message }}</div>
                            @enderror
                        </div>
                        <div class="mb-3">
                            <label for="password_confirmation" class="form-label">Confirm Password</label>
                            <input type="password" id="password_confirmation" class="form-control" name="password_confirmation" required>
                        </div>
                        <button type="submit" class="btn btn-primary w-100">Register</button>
                    </form>
                  
                    <div class="text-center mt-3">
                        <span>Already have an account?</span>
                        <a href="{{ route('admin.login') }}" class="text-primary">Login here</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection

@push('styles')
<style>
    .bg-orange {
        background-color: #f57c00;
    }
</style>
@endpush
