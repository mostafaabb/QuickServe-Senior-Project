<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Admin Panel | @yield('title', 'Dashboard')</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { font-family: 'Segoe UI', sans-serif; }
    .sidebar { height: 100vh; background: #343a40; }
    .sidebar a { color: #fff; padding:12px 20px; display:block; }
    .sidebar a.active, .sidebar a:hover { background: #495057; }
    .content-wrapper { margin-left:250px; padding:20px; }
    @media(max-width:768px){ .sidebar{position:absolute;width:100%;} .content-wrapper{margin-left:0;} }
  </style>
</head>
<body>
  <div class="sidebar position-fixed p-3">
    <h4 class="text-white">🍔 Admin Panel</h4>
    <a href="{{ route('admin.dashboard') }}" class="{{ request()->routeIs('admin.dashboard')?'active':'' }}">Dashboard</a>
    <a href="{{ route('admin.foods.index') }}" class="{{ request()->routeIs('admin.food*')?'active':'' }}">Manage Foods</a>
    <a href="{{ route('admin.users.index') }}" class="{{ request()->routeIs('admin.users*')?'active':'' }}">Users</a>
    <form action="{{ route('admin.logout') }}" method="POST" class="mt-3">
      @csrf
      <button class="btn btn-danger w-100">Logout</button>
    </form>
  </div>
  <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm" style="margin-left:250px;">
    <div class="container-fluid">
      <span class="navbar-brand">Welcome, {{ Auth::user()->name ?? 'Admin' }}</span>
    </div>
  </nav>
  <main class="content-wrapper">@yield('content')</main>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>