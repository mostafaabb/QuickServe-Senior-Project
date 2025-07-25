<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel</title>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Font Awesome for Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

    <!-- Custom Styles -->
    <style>
    /* Sidebar Styles */
    #sidebar-wrapper {
        min-height: 100vh;
        width: 250px;
        transition: all 0.3s ease;
        background-color: #343a40;
    }

    #sidebar-wrapper.toggled {
        margin-left: -250px;
    }

    #sidebar-wrapper .sidebar-heading {
        background-color: #007bff;
        color: white;
        text-align: center;
        padding: 20px 0;
        font-size: 1.5rem;
        font-weight: bold;
    }

    #sidebar-wrapper .list-group-item {
        padding: 15px;
        font-size: 16px;
        color: white;
        background-color: #343a40;
        border: none;
        transition: background-color 0.3s ease, color 0.3s ease;
    }

    #sidebar-wrapper .list-group-item:hover,
    #sidebar-wrapper .active {
        background-color: #007bff;
        color: white;
    }

    #sidebar-wrapper .list-group-item i {
        margin-right: 10px;
        font-size: 18px;
    }

    /* Navbar Styles */
    .navbar {
        background-color: #f8f9fa;
        box-shadow: 0 4px 2px -2px gray;
    }

    .navbar .navbar-nav .nav-item .nav-link {
        color: #007bff !important;
        font-weight: 600;
    }

    .navbar .navbar-nav .nav-item .nav-link:hover {
        color: #0056b3 !important;
    }

    /* Page Content Styles */
    #page-content-wrapper {
        width: 100%;
        transition: margin-left 0.3s ease;
    }

    /* Sidebar Toggle Button */
    #menu-toggle {
        background-color: #007bff;
        border: none;
        color: white;
        padding: 10px 15px;
        font-size: 18px;
        border-radius: 5px;
        box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
    }

    #menu-toggle:hover {
        background-color: #0056b3;
        cursor: pointer;
    }

    /* Responsive Layout */
    @media (max-width: 768px) {
        #sidebar-wrapper {
            width: 200px;
        }

        #sidebar-wrapper.toggled {
            margin-left: -200px;
        }

        #menu-toggle {
            font-size: 16px;
        }
    }
</style>

</head>

<body>
    <div class="d-flex" id="wrapper">
        <!-- Sidebar -->
        <div class="bg-dark text-white" id="sidebar-wrapper">
            <div class="sidebar-heading bg-primary text-center py-4 mb-4">
                <h4 class="text-white">QuickServe</h4>
            </div>
            <div class="list-group list-group-flush">
                <a href="{{ route('admin.dashboard') }}" class="list-group-item list-group-item-action text-white bg-dark {{ request()->routeIs('admin.dashboard') ? 'active' : '' }}">
                    <i class="fas fa-tachometer-alt me-2"></i> Dashboard
                </a>
                <a href="{{ route('admin.users.index') }}" class="list-group-item list-group-item-action text-white bg-dark {{ request()->routeIs('admin.users.*') ? 'active' : '' }}">
                    <i class="fas fa-users me-2"></i> User Management
                </a>
                <a href="{{ route('admin.foods.index') }}" class="list-group-item list-group-item-action text-white bg-dark {{ request()->routeIs('admin.foods.*') ? 'active' : '' }}">
                    <i class="fas fa-utensils me-2"></i> Menu Management
                </a>
                <a href="{{ route('admin.orders.index') }}" class="list-group-item list-group-item-action text-white bg-dark {{ request()->routeIs('admin.orders.*') ? 'active' : '' }}">
                    <i class="fas fa-receipt me-2"></i> Order Management
                </a>
                <a href="{{ route('admin.categories.index') }}" class="list-group-item list-group-item-action text-white bg-dark {{ request()->routeIs('admin.categories.*') ? 'active' : '' }}">
                    <i class="fas fa-tags me-2"></i>Category Management
                </a>
                <a href="{{ route('admin.revenue') }}" class="list-group-item list-group-item-action text-white bg-dark {{ request()->routeIs('admin.revenue') ? 'active' : '' }}">
                    <i class="fas fa-dollar-sign me-2"></i> Revenue Overview
                <!-- </a>
                <a href="{{ route('admin.restaurants.index') }}" class="list-group-item list-group-item-action text-white bg-dark {{ request()->routeIs('admin.restaurants.index') ? 'active' : '' }}">
    <i class="fas fa-utensils me-2"></i> Restaurants List
</a> -->

<a href="{{ route('admin.restaurants.index') }}" class="list-group-item list-group-item-action text-white bg-dark {{ request()->routeIs('admin.restaurants.index') ? 'active' : '' }}">
    <i class="fas fa-store me-2"></i> Restaurants
</a>

<a href="{{ route('admin.offers.index') }}" class="list-group-item list-group-item-action text-white bg-dark {{ request()->routeIs('admin.offers.index') ? 'active' : '' }}">
    <i class="fas fa-tags me-2"></i> Offers
</a>

 <a href="{{ route('admin.buses.index') }}" class="list-group-item list-group-item-action text-white bg-dark {{ request()->routeIs('admin.buses.*') ? 'active' : '' }}">
                    <i class="fas fa-bus me-2"></i> Bus Management
                </a>


         <a href="{{ route('admin.drivers.index') }}" class="list-group-item list-group-item-action text-white bg-dark {{ request()->routeIs('admin.drivers.*') ? 'active' : '' }}">
                    <i class="fas fa-bus me-2"></i> Drivers Management
                </a>     
                
                <a href="{{ route('admin.picnic_places.index') }}" 
   class="list-group-item list-group-item-action text-white bg-dark {{ request()->routeIs('admin.picnic_places.*') ? 'active' : '' }}">
   <i class="fas fa-tree me-2"></i> Picnic Places
</a>

                <a href="{{ route('admin.reports') }}" class="list-group-item list-group-item-action text-white bg-dark {{ request()->routeIs('admin.reports') ? 'active' : '' }}">
                    <i class="fas fa-chart-pie me-2"></i> Analytics & Reports
                </a>
                <a href="{{ route('admin.settings') }}" class="list-group-item list-group-item-action text-white bg-dark {{ request()->routeIs('admin.settings') ? 'active' : '' }}">
                    <i class="fas fa-cogs me-2"></i> System Settings
                </a>

                <a href="{{ route('admin.ratings.index') }}" 
   class="list-group-item list-group-item-action text-white bg-dark {{ request()->routeIs('admin.ratings.*') ? 'active' : '' }}">
   <i class="fas fa-star me-2"></i> User Ratings
</a>

                <form action="{{ route('admin.logout') }}" method="POST" class="d-inline">
                    @csrf
                    <button type="submit" class="list-group-item list-group-item-action text-danger border-0 bg-dark">
                        <i class="fas fa-sign-out-alt me-2"></i> Logout
                    </button>
                </form>
            </div>
        </div>

        <!-- Page Content -->
        <div id="page-content-wrapper">
            <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
                <button class="btn btn-primary" id="menu-toggle"><i class="fas fa-bars"></i></button>
            </nav>

            <div class="container-fluid px-4">
                @yield('content')
            </div>
        </div>
    </div>

    <!-- Bootstrap JS & jQuery (for Bootstrap features like collapsible sidebar) -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Sidebar Toggle Script -->
    <script>
        // Toggle Sidebar
        document.getElementById('menu-toggle').addEventListener('click', function () {
            document.getElementById('sidebar-wrapper').classList.toggle('toggled');
        });
    </script>

    @yield('scripts')
</body>

</html>
