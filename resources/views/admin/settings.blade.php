@extends('admin.layout')

@section('content')
    <div class="container">
        <h1>⚙️Settings</h1>

        @if (session('success'))
            <div class="alert alert-success">
                {{ session('success') }}
            </div>
        @endif

        <form action="{{ route('admin.settings.update') }}" method="POST">
            @csrf

            <div class="form-group">
                <label for="site_name">Site Name</label>
                <input type="text" name="site_name" id="site_name" class="form-control" value="{{ old('site_name', $settings['site_name']) }}" required>
                @error('site_name')
                    <div class="text-danger">{{ $message }}</div>
                @enderror
            </div>

            <div class="form-group">
                <label for="site_email">Site Email</label>
                <input type="email" name="site_email" id="site_email" class="form-control" value="{{ old('site_email', $settings['site_email']) }}" required>
                @error('site_email')
                    <div class="text-danger">{{ $message }}</div>
                @enderror
            </div>

            <div class="form-group">
                <label for="maintenance_mode">Maintenance Mode</label>
                <input type="checkbox" name="maintenance_mode" id="maintenance_mode" value="1" {{ old('maintenance_mode', $settings['maintenance_mode']) ? 'checked' : '' }}>
                @error('maintenance_mode')
                    <div class="text-danger">{{ $message }}</div>
                @enderror
            </div>

            <button type="submit" class="btn btn-primary">Save Settings</button>
        </form>
    </div>
@endsection
