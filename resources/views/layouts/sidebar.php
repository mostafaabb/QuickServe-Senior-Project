<div class="d-flex flex-column p-3 bg-light" style="width: 250px; height: 100vh;">
    <a href="{{ route('admin.dashboard') }}" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-dark text-decoration-none">
        <span class="fs-4">Admin Panel</span>
    </a>
    <hr>
    <ul class="nav nav-pills flex-column mb-auto">
        <li class="nav-item">
            <a href="{{ route('admin.dashboard') }}" class="nav-link active" aria-current="page">
                Dashboard
            </a>
        </li>
        <li>
            <a href="{{ route('admin.food.index') }}" class="nav-link text-dark">
                Food Items
            </a>
        </li>
        <li>
            <a href="{{ route('admin.users.index') }}" class="nav-link text-dark">
                Users
            </a>
        </li>
    </ul>
    <hr>
    <div class="dropdown">
        <form method="POST" action="{{ route('logout') }}">
            @csrf
            <button type="submit" class="btn btn-outline-danger w-100">Logout</button>
        </form>
    </div>
</div>
