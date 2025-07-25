<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Driver;
use App\Models\DriverRequest;
use Carbon\Carbon;


class DriverController extends Controller
{
    public function index(Request $request)
{
    $query = \App\Models\Driver::query();

    // Apply search if exists
    if ($request->filled('search')) {
        $search = $request->search;
        $query->where('name', 'like', "%$search%")
              ->orWhere('email', 'like', "%$search%")
              ->orWhere('phone', 'like', "%$search%");
    }

    $drivers = $query->orderBy('id', 'asc')->paginate(10);

    return view('admin.drivers.index', compact('drivers'));
}

    public function create()
    {
        return view('admin.drivers.create');
    }

    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'phone' => 'required|string',
            'email' => 'required|email|unique:drivers,email',
            'vehicle_type' => 'required|string',
            'vehicle_number' => 'required|string',
            'status' => 'required|string',
        ]);

        Driver::create($request->all());

        return redirect()->route('admin.drivers.index')->with('success', 'Driver added successfully.');
    }

     public function edit($id)
    {
        $driver = Driver::findOrFail($id);
        return view('admin.drivers.edit', compact('driver'));
    }

     public function update(Request $request, $id)
    {
        $driver = Driver::findOrFail($id);

        $request->validate([
            'name' => 'required|string',
            'phone' => 'required|string',
            'email' => 'required|email|unique:drivers,email,' . $id,
            'vehicle_type' => 'required|string',
            'vehicle_number' => 'required|string',
            'status' => 'required|string',
        ]);

        $driver->update($request->all());

        return redirect()->route('admin.drivers.index')->with('success', 'Driver updated successfully.');
    }

    public function destroy($id)
    {
        $driver = Driver::findOrFail($id);
        $driver->delete();

        return redirect()->route('admin.drivers.index')->with('success', 'Driver deleted successfully.');
    }

  public function booked()
{
    $yesterday = Carbon::now()->subDay();

    // Fetch booked driver requests in the last 24 hours with user and driver relations, paginated
    $bookedRequests = DriverRequest::with(['user', 'driver'])
        ->where('created_at', '>=', $yesterday)
        ->paginate(15);

    return view('admin.drivers.booked', compact('bookedRequests'));
}
}
