<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\LoginController;
use App\Http\Controllers\Auth\RegisterController;
use App\Http\Controllers\Admin\Auth\LoginController as AdminLoginController;
use App\Http\Controllers\Admin\DashboardController;
use App\Http\Controllers\Admin\FoodController;
use App\Http\Controllers\Admin\OrderController;
use App\Http\Controllers\Admin\UserController;
use App\Http\Controllers\Admin\CategoryController;
use App\Http\Controllers\Admin\SearchController;
use App\Http\Controllers\Admin\ReportController;
use App\Http\Controllers\Admin\SettingController;
use App\Http\Controllers\Admin\RestaurantController;
use App\Http\Controllers\Admin\OfferController;
use App\Http\Controllers\Admin\AdminController; // For revenue route
use App\Http\Controllers\Admin\RatingController;  // <-- Add this line
use App\Http\Controllers\Admin\BusController; // Added bus controller
use App\Http\Controllers\Admin\DriverController;
use App\Http\Controllers\Admin\PicnicPlaceController;

// Public admin auth routes
Route::get('admin/login', [AdminLoginController::class, 'showLoginForm'])->name('admin.login');
Route::post('admin/login', [AdminLoginController::class, 'login'])->name('admin.login.submit');

Route::get('admin/register', [RegisterController::class, 'showRegistrationForm'])->name('admin.register');
Route::post('admin/register', [RegisterController::class, 'register'])->name('admin.register.submit');

// Redirect root to admin login
Route::get('/', function () {
    return redirect()->route('admin.login');
});

// Admin protected routes
Route::prefix('admin')->name('admin.')->middleware('auth:admin')->group(function () {
    Route::get('orders/pending', [OrderController::class, 'pending'])->name('orders.pending');
    Route::get('orders/canceled', [OrderController::class, 'canceled'])->name('orders.canceled');
    Route::get('orders/completed', [OrderController::class, 'completed'])->name('orders.completed');
    
    // Dashboard
    Route::get('dashboard', [DashboardController::class, 'index'])->name('dashboard');

    // Resources
    Route::resource('foods', FoodController::class);
    Route::resource('users', UserController::class);
    Route::resource('orders', OrderController::class);
    Route::resource('categories', CategoryController::class);
    Route::resource('restaurants', RestaurantController::class);
    Route::resource('offers', OfferController::class); // Corrected resource name to 'offers'
    // Route::resource('buses', BusController::class)->except(['show']);
    Route::resource('ratings', RatingController::class)->only(['index']);  // <-- Add this line
    // Route::resource('buses', BusController::class);
    Route::resource('picnic_places', PicnicPlaceController::class);
    // Extra admin features
    Route::get('search', [SearchController::class, 'index'])->name('search');
    Route::get('revenue', [DashboardController::class, 'revenue'])->name('revenue');
    Route::get('reports', [ReportController::class, 'index'])->name('reports');
    Route::get('settings', [SettingController::class, 'index'])->name('settings');
    Route::post('settings/update', [SettingController::class, 'update'])->name('settings.update');

    Route::get('drivers', [DriverController::class, 'index'])->name('drivers.index');
    Route::get('drivers/create', [DriverController::class, 'create'])->name('drivers.create');
    Route::post('drivers', [DriverController::class, 'store'])->name('drivers.store');
    Route::get('drivers/booked', [DriverController::class, 'booked'])->name('drivers.booked');
    Route::get('/admin/drivers/booked', [DriverController::class, 'booked'])->name('admin.drivers.booked');
    Route::get('buses/booked', [BusController::class, 'bookedBuses'])->name('buses.booked');
    Route::resource('drivers', DriverController::class);
    Route::resource('buses', BusController::class)->except(['show']);
    // Admin logout
    Route::post('logout', [AdminLoginController::class, 'logout'])->name('logout');
});
