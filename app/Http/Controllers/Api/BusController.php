<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Bus;

class BusController extends Controller
{
    public function index()
    {
         $buses = Bus::where('available_seats', '>', 0)->get();

    return response()->json($buses);
    }

    public function store(Request $request)
    {
        $request->validate([
            'bus_number' => 'required|unique:buses',
            'driver_name' => 'required',
            'capacity' => 'required|integer',
            'available_seats' => 'required|integer',
            'departure_time' => 'required',
            'arrival_time' => 'required',
        ]);

        $bus = Bus::create($request->all());

        return response()->json($bus, 201);
    }

    public function show($id)
    {
        return response()->json(Bus::findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $bus = Bus::findOrFail($id);
        $bus->update($request->all());
        return response()->json($bus);
    }

    public function destroy($id)
    {
        Bus::destroy($id);
        return response()->json(['message' => 'Bus deleted']);
    }
}


