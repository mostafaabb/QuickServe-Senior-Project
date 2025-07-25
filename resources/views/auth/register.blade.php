<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Registration</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to right, #ff8800, #ffcc70);
            font-family: 'Segoe UI', sans-serif;
        }

        .register-box {
            background: #fff;
            padding: 35px;
            border-radius: 12px;
            margin-top: 80px;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .register-title {
            color: #ff8800;
            font-weight: bold;
        }

        .form-control:focus {
            border-color: #ff8800;
            box-shadow: 0 0 0 0.2rem rgba(255, 136, 0, 0.25);
        }

        .btn-orange {
            background-color: #ff8800;
            color: #fff;
        }

        .btn-orange:hover {
            background-color: #e67600;
        }
    </style>
</head>
<body>
<div class="container d-flex justify-content-center align-items-center min-vh-100">
    <div class="col-md-6 register-box">
        <h2 class="text-center register-title mb-4">📝 Admin Registration</h2>

        @if ($errors->any())
            <div class="alert alert-danger">
                <ul class="mb-0">
                    @foreach ($errors->all() as $error)
                        <li>{{ $error }}</li>
                    @endforeach
                </ul>
            </div>
        @endif

        <form method="POST" action="{{ route('admin.register.submit') }}">
            @csrf

            <div class="mb-3">
                <label class="form-label">Name</label>
                <input type="text" name="name" class="form-control" value="{{ old('name') }}" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Email</label>
                <input type="email" name="email" class="form-control" value="{{ old('email') }}" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" name="password" class="form-control" required>
            </div>

            <div class="mb-3">
                <label class="form-label">Confirm Password</label>
                <input type="password" name="password_confirmation" class="form-control" required>
            </div>

            <button type="submit" class="btn btn-orange w-100">Register</button>
        </form>

        <div class="text-center mt-3">
            Already have an account?
            <a href="{{ route('admin.login') }}" class="text-decoration-none" style="color:#ff8800;">Login here</a>
        </div>
    </div>
</div>
</body>
</html>
