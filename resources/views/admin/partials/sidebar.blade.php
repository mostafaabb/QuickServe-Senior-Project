<!-- Sidebar -->
<nav class="bg-dark text-white vh-100 p-3" style="width: 250px;">
    <h4 class="text-center mb-4">Admin Panel</h4>

    <ul class="nav flex-column">
        <li class="nav-item mb-2">
            <a href="{{ route('admin.dashboard') }}" class="nav-link text-white">
                <i class="fas fa-tachometer-alt me-2"></i> Dashboard
            </a>
        </li>
        <li class="nav-item mb-2">
            <a href="{{ route('admin.food.index') }}" class="nav-link text-white">
                <i class="fas fa-utensils me-2"></i> Food Management
            </a>
        </li>
        <li class="nav-item mb-2">
            <a href="{{ route('admin.users.index') }}" class="nav-link text-white">
                <i class="fas fa-users me-2"></i> Users
            </a>
        </li>

        <!-- Logout Form -->
        <li class="nav-item mt-4">
            <form method="POST" action="{{ route('logout') }}">
                @csrf
                <button type="submit" class="btn btn-danger w-100">
                    <i class="fas fa-sign-out-alt me-2"></i> Logout
                </button>
            </form>
        </li>
    </ul>
</nav>
