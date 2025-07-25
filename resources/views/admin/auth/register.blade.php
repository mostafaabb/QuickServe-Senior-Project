<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Registration</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- FontAwesome for icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to right, #ff8800, #ffcc70);
            font-family: 'Segoe UI', sans-serif;
        }

        .auth-box {
            background-color: #fff;
            padding: 40px 30px;
            border-radius: 15px;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }

        .auth-title {
            color: #ff8800;
            font-weight: bold;
            text-align: center;
            font-size: 2rem;
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

        .auth-link {
            color: #ff8800;
            text-decoration: none;
        }

        .auth-link:hover {
            text-decoration: underline;
        }

        .input-group-text {
            background-color: #ff8800;
            color: white;
        }

        .input-group .form-control {
            border-left: none;
        }

        .icon-input {
            border: 1px solid #ddd;
            border-radius: 5px;
        }

        .icon-input input {
            border: none;
            padding-left: 30px;
        }

        .icon-input i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #ff8800;
        }
    </style>
</head>
<body>
<div class="container d-flex justify-content-center align-items-center min-vh-100">
    <div class="col-md-6 col-lg-5">
        <div class="auth-box">
            <h2 class="auth-title mb-4">📝 Admin Registration</h2>

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

                <!-- Name Field -->
                <div class="mb-3 position-relative icon-input">
                    <i class="fas fa-user"></i>
                    <input type="text" name="name" class="form-control ps-5" value="{{ old('name') }}" placeholder="Enter Name" required>
                </div>

                <!-- Email Field -->
                <div class="mb-3 position-relative icon-input">
                    <i class="fas fa-envelope"></i>
                    <input type="email" name="email" class="form-control ps-5" value="{{ old('email') }}" placeholder="Enter Email" required>
                </div>

                <!-- Password Field -->
                <div class="mb-3 position-relative icon-input">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="password" class="form-control ps-5" placeholder="Enter Password" required>
                </div>

                <!-- Confirm Password Field -->
                <div class="mb-3 position-relative icon-input">
                    <i class="fas fa-lock"></i>
                    <input type="password" name="password_confirmation" class="form-control ps-5" placeholder="Confirm Password" required>
                </div>

                <button type="submit" class="btn btn-orange w-100">Register</button>
            </form>

            <div class="text-center mt-3">
                <span>Already have an account?</span>
                <a href="{{ route('admin.login') }}" class="auth-link">Login here</a>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS (Optional) -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
