<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\AuthController;
use App\Http\Controllers\Api\CategoryController;
use App\Http\Controllers\Api\FoodController;
use App\Http\Controllers\Api\OfferController;
use App\Http\Controllers\Api\OrderController;
use App\Http\Controllers\Api\RestaurantController;
use App\Http\Controllers\Api\UserController;
use App\Http\Controllers\Api\ProfileController;
use App\Http\Controllers\Api\RatingController;
use App\Http\Controllers\Api\CartController;
use App\Http\Controllers\Api\RewardController;
use App\Http\Controllers\AIController;
use App\Http\Controllers\Admin\Auth\PasswordResetController;
use App\Http\Controllers\Api\BusController;
use App\Http\Controllers\Api\BusBookingController;
use App\Http\Controllers\DriverRequestController;
use App\Http\Controllers\DriverController;
use App\Http\Controllers\API\PicnicPlaceController;


// Public routes for authentication
Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::get('/foods/trending', [FoodController::class, 'getTrendingFoods']);
// Password Reset Routes
Route::post('/forgot-password', [PasswordResetController::class, 'sendResetLinkEmail']);
Route::post('/verify-reset-code', [PasswordResetController::class, 'verifyCode']);
Route::post('/reset-password', [PasswordResetController::class, 'resetPassword']);

// AI Chatbot
Route::post('/ask-ai', [AIController::class, 'ask']);

// Public read-only routes
Route::apiResource('/foods', FoodController::class)->except(['create', 'edit']);
Route::apiResource('/categories', CategoryController::class)->except(['create', 'edit']);
Route::apiResource('/offers', OfferController::class)->except(['create', 'edit']);
Route::apiResource('/restaurants', RestaurantController::class)->except(['create', 'edit']);
Route::apiResource('/users', UserController::class)->except(['create', 'edit']);
Route::apiResource('/buses', BusController::class)->except(['create', 'edit']);
Route::get('/bus-bookings/my', [BusBookingController::class, 'myBookings']);    // GET with query param user_id
Route::post('/bus-bookings', [BusBookingController::class, 'book']);           // POST with user_id in body
Route::delete('/bus-bookings/{id}', [BusBookingController::class, 'cancel']);  // DELETE with user_id in body
Route::put('/bus-bookings/{id}', [BusBookingController::class, 'update']);
// Orders - only POST allowed (create order)
Route::post('/orders', [OrderController::class, 'store']);

Route::apiResource('picnic_places', PicnicPlaceController::class);

// Additional public routes
Route::get('/latest-updates', [FoodController::class, 'latestUpdates']);

// Profile routes (public)
Route::get('/profile/{id}', [ProfileController::class, 'show']);
Route::put('/profile/{id}', [ProfileController::class, 'update']);

// Ratings
Route::get('/ratings/average', [RatingController::class, 'averageRating']);
Route::post('/ratings', [RatingController::class, 'store']);

// Cart routes (public)
Route::post('/cart/add', [CartController::class, 'addToCart']);
Route::get('/cart', [CartController::class, 'getCart']);

// Rewards routes (public)
Route::get('/rewards', [RewardController::class, 'index']);
Route::post('/rewards', [RewardController::class, 'store']);
Route::post('/rewards/redeem', [RewardController::class, 'redeem']);
Route::post('/rewards/{id}/mark-used', [RewardController::class, 'markUsed']);

Route::post('/driver-request', [DriverRequestController::class, 'store']);
    Route::get('/driver-requests', [DriverRequestController::class, 'index']);
    Route::put('/driver-request/{id}/status', [DriverRequestController::class, 'updateStatus']);

    Route::get('/drivers', [DriverController::class, 'index']);       // List all drivers (available)
Route::post('/drivers', [DriverController::class, 'store']);      // Create new driver
Route::get('/drivers/{id}', [DriverController::class, 'show']);   // Show driver details
Route::put('/drivers/{id}', [DriverController::class, 'update']); // Update driver info
Route::delete('/drivers/{id}', [DriverController::class, 'destroy']); // Delete driver

// Protected logout route
Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    
});