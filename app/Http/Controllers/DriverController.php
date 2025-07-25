<?php

namespace App\Http\Controllers;

use App\Models\Driver;
use Illuminate\Http\Request;

class DriverController extends Controller
{
    // List all available drivers
    public function index()
    {
        $drivers = Driver::where('status', 'available')->get();

        return response()->json([
            'data' => $drivers
        ]);
    }

    // Create a new driver (admin)
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'phone' => 'required|string|max:20',
            'email' => 'nullable|email|unique:drivers,email',
            'vehicle_type' => 'required|string|max:100',
            'vehicle_number' => 'required|string|max:50',
            'status' => 'nullable|in:available,busy,offline',
        ]);

        $driver = Driver::create([
            'name' => $request->name,
            'phone' => $request->phone,
            'email' => $request->email,
            'vehicle_type' => $request->vehicle_type,
            'vehicle_number' => $request->vehicle_number,
            'status' => $request->status ?? 'available',
        ]);

        return response()->json([
            'message' => 'Driver created successfully',
            'data' => $driver
        ], 201);
    }

    // Show a driver details
    public function show($id)
    {
        $driver = Driver::findOrFail($id);

        return response()->json([
            'data' => $driver
        ]);
    }

    // Update a driver (admin)
    public function update(Request $request, $id)
    {
        $driver = Driver::findOrFail($id);

        $request->validate([
            'name' => 'sometimes|required|string|max:255',
            'phone' => 'sometimes|required|string|max:20',
            'email' => 'sometimes|nullable|email|unique:drivers,email,' . $id,
            'vehicle_type' => 'sometimes|required|string|max:100',
            'vehicle_number' => 'sometimes|required|string|max:50',
            'status' => 'sometimes|in:available,busy,offline',
        ]);

        $driver->update($request->only([
            'name', 
            'phone', 
            'email', 
            'vehicle_type', 
            'vehicle_number', 
            'status'
        ]));

        return response()->json([
            'message' => 'Driver updated successfully',
            'data' => $driver
        ]);
    }

    // Delete a driver (admin)
    public function destroy($id)
    {
        $driver = Driver::findOrFail($id);
        $driver->delete();

        return response()->json([
            'message' => 'Driver deleted successfully',
        ]);
    }
}
