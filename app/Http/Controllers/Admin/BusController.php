<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Bus;
use Illuminate\Support\Facades\DB;
use Carbon\Carbon;


class BusController extends Controller
{
    public function index(Request $request)
{
    $query = Bus::query();

    if ($request->filled('search')) {
        $search = $request->search;
        $query->where('bus_number', 'like', "%$search%")
              ->orWhere('driver_name', 'like', "%$search%")
              ->orWhere('route', 'like', "%$search%");
    }

    $buses = $query->orderBy('id', 'asc')->paginate(10);

    return view('admin.buses.index', compact('buses'));
}
    public function show($id)
{
    $bus = Bus::findOrFail($id);
    return view('admin.buses.show', compact('bus'));
}

    public function create()
    {
        return view('admin.buses.create');
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'bus_number' => 'required|string',
            'driver_name' => 'required|string',
            'capacity' => 'required|integer',
            'available_seats' => 'required|integer',
            'departure_time' => 'required|date_format:H:i',
            'arrival_time' => 'required|date_format:H:i',
            'route' => 'required|string',
        ]);

        Bus::create($validated);

        return redirect()->route('admin.buses.index')->with('success', 'Bus created successfully.');
    }

    public function edit(Bus $bus)
    {
        return view('admin.buses.edit', compact('bus'));
    }

    public function update(Request $request, Bus $bus)
    {
        $validated = $request->validate([
            'bus_number' => 'required|string',
            'driver_name' => 'required|string',
            'capacity' => 'required|integer',
            'available_seats' => 'required|integer',
            'departure_time' => 'required|date_format:H:i',
            'arrival_time' => 'required|date_format:H:i',
            'route' => 'required|string',
        ]);

        $bus->update($validated);

        return redirect()->route('admin.buses.index')->with('success', 'Bus updated successfully.');
    }

    public function destroy(Bus $bus)
    {
        $bus->delete();
        return redirect()->route('admin.buses.index')->with('success', 'Bus deleted successfully.');
    }

   public function bookedBuses()
{
    $yesterday = Carbon::now()->subDay();

    $bookedBuses = DB::table('bus_bookings')
        ->join('buses', 'bus_bookings.bus_id', '=', 'buses.id')
        ->join('users', 'bus_bookings.user_id', '=', 'users.id')
        ->select(
            'bus_bookings.id',
            'users.name as user_name',
            'buses.bus_number',
            'buses.route',
            'bus_bookings.seats_booked',
            'bus_bookings.created_at'
        )
        ->where('bus_bookings.created_at', '>=', $yesterday)
        ->orderBy('bus_bookings.created_at', 'desc')
        ->get();

    return view('admin.buses.booked', compact('bookedBuses'));
}
}
