<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class SettingController extends Controller
{
    // Display the settings page
    public function index()
    {
        // Here you can fetch your settings from a database or configuration file
        // For example, we can return a simple view with default data

        // Example of settings data, you may fetch from the database or a config file
        $settings = [
            'site_name' => 'My Food Delivery System',
            'site_email' => 'admin@example.com',
            'maintenance_mode' => false, // Example of a toggleable setting
        ];

        return view('admin.settings', compact('settings'));
    }

    // Update the settings
    public function update(Request $request)
    {
        // Validate the incoming request data
        $request->validate([
            'site_name' => 'required|string|max:255',
            'site_email' => 'required|email',
            'maintenance_mode' => 'required|boolean',
        ]);

        // Here you could save the settings to the database
        // For this example, we're just going to simulate saving the settings
        // You would likely update a database model, or a configuration file

        // Simulate updating the settings (this could be a database operation)
        // Example: Settings::update(['site_name' => $request->site_name]);

        // You can flash a success message after saving
        session()->flash('success', 'Settings updated successfully!');

        return redirect()->route('admin.settings');
    }
}
