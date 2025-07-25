<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">

    <style>
        body {
            background: linear-gradient(to right, #ff8800, #ffcc70);
            font-family: 'Segoe UI', sans-serif;
            min-height: 100vh;
        }

        .login-box {
            background: #fff;
            padding: 40px 35px;
            border-radius: 15px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 450px;
        }

        .login-title {
            color: #ff8800;
            font-weight: bold;
            font-size: 28px;
        }

        .input-group-text {
            background-color: #fff;
            border-right: 0;
        }

        .form-control {
            border-left: 0;
        }

        .form-control:focus {
            border-color: #ff8800;
            box-shadow: 0 0 0 0.25rem rgba(255, 136, 0, 0.2);
        }

        .btn-orange {
            background-color: #ff8800;
            color: #fff;
            font-weight: 600;
        }

        .btn-orange:hover {
            background-color: #e67600;
        }

        .register-link {
            color: #ff8800;
            text-decoration: none;
            font-weight: 500;
        }

        .register-link:hover {
            text-decoration: underline;
        }

        .icon-box {
            font-size: 45px;
            color: #ff8800;
        }
    </style>
</head>
<body>
    <div class="d-flex justify-content-center align-items-center vh-100">
        <div class="login-box">
            <div class="text-center mb-4">
                <i class="bi bi-shield-lock-fill icon-box"></i>
                <h2 class="login-title mt-2">Admin Login</h2>
            </div>

            @if (session('error'))
                <div class="alert alert-danger">
                    {{ session('error') }}
                </div>
            @endif

            <form method="POST" action="{{ route('admin.login.submit') }}">
                @csrf

                <div class="mb-3">
                    <label class="form-label">Email Address</label>
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="bi bi-envelope-fill"></i>
                        </span>
                        <input type="email" name="email" class="form-control" required value="{{ old('email') }}">
                    </div>
                </div>

                <div class="mb-4">
                    <label class="form-label">Password</label>
                    <div class="input-group">
                        <span class="input-group-text">
                            <i class="bi bi-lock-fill"></i>
                        </span>
                        <input type="password" name="password" class="form-control" required>
                    </div>
                </div>

                <div class="d-grid">
                    <button type="submit" class="btn btn-orange">
                        <i class="bi bi-box-arrow-in-right me-1"></i> Login
                    </button>
                </div>
            </form>

            <!-- <div class="text-center mt-4">
                Don’t have an account?
                <a href="{{ route('admin.register') }}" class="register-link">Register here</a>
            </div> -->
        </div>
    </div>

    <!-- Bootstrap JS (Optional, for dropdowns/modals if needed) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
