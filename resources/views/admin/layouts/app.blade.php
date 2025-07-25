<!-- resources/views/layouts/app.blade.php -->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>@yield('title', 'Admin Panel')</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="sidebar">
    <ul class="list-unstyled">
        <!-- Dashboard Link -->
        <li class="nav-item">
            <a href="{{ route('admin.dashboard') }}" class="nav-link">
                <i class="fas fa-tachometer-alt" style="margin-right: 8px;"></i> Dashboard
            </a>
        </li>

        <!-- Users Link -->
        <li class="nav-item">
            <a href="{{ route('admin.users.index') }}" class="nav-link">
                <i class="fas fa-users" style="margin-right: 8px;"></i> Users
            </a>
        </li>

        <!-- Food Link -->
        <li class="nav-item">
            <a href="{{ route('admin.foods.index') }}" class="nav-link">
                <i class="fas fa-hamburger" style="margin-right: 8px;"></i> Food
            </a>
        </li>

        <!-- Logout Link -->
        <li class="nav-item">
            <a href="{{ route('admin.logout') }}" class="nav-link">
                <i class="fas fa-sign-out-alt" style="margin-right: 8px;"></i> Logout
            </a>
        </li>
    </ul>
</div>


        <!-- Main Content -->
        <div class="col-md-9 p-4">
            @yield('content')
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
