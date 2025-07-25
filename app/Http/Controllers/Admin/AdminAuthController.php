<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Admin;  // Assuming you have an Admin model

class AuthController extends Controller
{
    // Show the registration form
    public function showRegisterForm()
    {
        return view('admin.register'); // Adjust the view path as needed
    }

    // Handle the registration form submission
    public function register(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|string|email|max:255|unique:admins',
            'password' => 'required|string|min:8|confirmed',
        ]);

        // Create a new admin user
        Admin::create([
            'name' => $validated['name'],
            'email' => $validated['email'],
            'password' => bcrypt($validated['password']),
        ]);

        // Redirect to login page after successful registration
        return redirect()->route('admin.login');
    }
}
