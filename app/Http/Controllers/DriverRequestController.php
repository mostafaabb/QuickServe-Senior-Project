<?php

namespace App\Http\Controllers;

use App\Models\DriverRequest;
use Illuminate\Http\Request;

class DriverRequestController extends Controller
{
    // Create new driver request (public API)
    public function store(Request $request)
    {
        $validated = $request->validate([
            'user_id' => 'required|exists:users,id',
            'description' => 'required|string',
            'pickup_location' => 'nullable|string',
            'dropoff_location' => 'nullable|string',
            'price' => 'nullable|numeric',
            'driver_id' => 'nullable|exists:users,id',
        ]);

        $driverRequest = DriverRequest::create([
            ...$validated,
            'status' => 'pending',
        ]);

        return response()->json([
            'message' => 'Driver request created successfully',
            'data' => $driverRequest,
        ], 201);
    }

    // API: Get all requests with user relation
    public function index()
    {
        $requests = DriverRequest::with('user')
            ->orderByDesc('created_at')
            ->get();

        return response()->json([
            'data' => $requests
        ]);
    }

    // API: Update request status, driver, or price
    public function updateStatus(Request $request, $id)
    {
        $validated = $request->validate([
            'status' => 'required|in:pending,accepted,completed,cancelled',
            'driver_id' => 'nullable|exists:users,id',
            'price' => 'nullable|numeric',
        ]);

        $driverRequest = DriverRequest::findOrFail($id);
        $driverRequest->status = $validated['status'];

        if (isset($validated['driver_id'])) {
            $driverRequest->driver_id = $validated['driver_id'];
        }

        if (isset($validated['price'])) {
            $driverRequest->price = $validated['price'];
        }

        $driverRequest->save();

        return response()->json([
            'message' => 'Driver request updated',
            'data' => $driverRequest
        ]);
    }

    // Admin panel: List all driver requests with user & driver info
    public function adminIndex()
    {
        $driverRequests = DriverRequest::with(['user', 'driver'])->orderByDesc('created_at')->get();

        return view('admin.driver_requests.index', compact('driverRequests'));
    }

    // Admin panel: Show edit form for a specific driver request
    public function edit($id)
    {
        $driverRequest = DriverRequest::with(['user', 'driver'])->findOrFail($id);

        // You might want to load all drivers for a select dropdown to assign/reassign drivers
        $drivers = \App\Models\User::where('role', 'driver')->get();

        return view('admin.driver_requests.edit', compact('driverRequest', 'drivers'));
    }

    // Admin panel: Update driver request from edit form
    public function update(Request $request, $id)
    {
        $validated = $request->validate([
            'status' => 'required|in:pending,accepted,completed,cancelled',
            'driver_id' => 'nullable|exists:users,id',
            'price' => 'nullable|numeric',
        ]);

        $driverRequest = DriverRequest::findOrFail($id);
        $driverRequest->status = $validated['status'];
        $driverRequest->driver_id = $validated['driver_id'] ?? null;
        $driverRequest->price = $validated['price'] ?? null;
        $driverRequest->save();

        return redirect()->route('admin.driver_requests.index')
            ->with('success', 'Driver request updated successfully.');
    }
}
