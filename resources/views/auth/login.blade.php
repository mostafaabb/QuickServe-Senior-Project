@extends('layouts.app')

@section('title', 'Admin Login')

@section('content')
<div class="container d-flex justify-content-center align-items-center" style="min-height: 100vh; background-color: #f9f9f9;">
    <div class="card shadow p-4" style="width: 400px; border-top: 4px solid #ff8800; border-radius: 12px;">
        <h3 class="text-center mb-4" style="color: #ff8800;">🔐 Admin Login</h3>

        @if(session('status'))
            <div class="alert alert-danger">{{ session('status') }}</div>
        @endif

        <form method="POST" action="{{ route('login') }}">
            @csrf

            <div class="mb-3">
                <label for="email" class="form-label">Email Address</label>
                <input type="email" class="form-control @error('email') is-invalid @enderror"
                       id="email" name="email" value="{{ old('email') }}" required autofocus>
                @error('email')
                    <div class="text-danger small">{{ $message }}</div>
                @enderror
            </div>

            <div class="mb-3">
                <label for="password" class="form-label">Password</label>
                <input type="password" class="form-control @error('password') is-invalid @enderror"
                       id="password" name="password" required>
                @error('password')
                    <div class="text-danger small">{{ $message }}</div>
                @enderror
            </div>

            <div class="form-check mb-3">
                <input type="checkbox" class="form-check-input" name="remember" id="remember">
                <label class="form-check-label" for="remember">Remember Me</label>
            </div>

            <div class="d-grid">
                <button type="submit" class="btn btn-warning text-white">Login</button>
            </div>

            <div class="text-center mt-3">
                <a href="{{ route('register') }}" style="color: #ff8800;">Don't have an account? Register</a>
            </div>
        </form>
    </div>
</div>
@endsection
