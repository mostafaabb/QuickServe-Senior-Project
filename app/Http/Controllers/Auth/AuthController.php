<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use App\Models\User; // Use the appropriate model (User, Admin, etc.)

class AuthController extends Controller
{
    // Show the login form
    public function showLoginForm()
    {
        return view('auth.login'); // The login view page
    }

    // Handle the login request
    public function login(Request $request)
    {
        $credentials = $request->only('email', 'password');

        // Attempt to log the user in
        if (Auth::attempt($credentials)) {
            return redirect()->route('home'); // Redirect to a page after successful login
        }

        // If login fails, redirect back with an error
        return back()->withErrors([
            'email' => 'Invalid credentials.',
        ]);
    }

    // Handle the registration request (if needed for users)
    public function showRegistrationForm()
    {
        return view('auth.register'); // The register view page
    }

    // Store the registration data (if needed for users)
    public function register(Request $request)
    {
        // Validate the incoming request data
        $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:users',
            'password' => 'required|string|confirmed|min:8',
        ]);

        // Create a new user
        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password),
        ]);

        // Automatically log the user in after registration
        Auth::login($user);

        // Redirect to home page after successful registration
        return redirect()->route('home');
    }

    // Handle the logout request
    public function logout(Request $request)
    {
        Auth::logout();
        $request->session()->invalidate();
        $request->session()->regenerateToken();

        // Redirect to login page after logout
        return redirect()->route('login');
    }
}
