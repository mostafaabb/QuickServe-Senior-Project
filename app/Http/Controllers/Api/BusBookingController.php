<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\Bus;
use App\Models\BusBooking;

class BusBookingController extends Controller
{
    // Get all available buses
    public function availableBuses()
    {
        $buses = Bus::where('available_seats', '>', 0)->get();
        return response()->json(['buses' => $buses], 200);
    }

    // Book a bus 
    public function book(Request $request)
    {
        // Validate input including user_id
        $request->validate([
            'user_id' => 'required|exists:users,id',
            'bus_id' => 'required|exists:buses,id',
            'seats_booked' => 'required|integer|min:1',
        ]);

        $bus = Bus::findOrFail($request->bus_id);

        if ($bus->available_seats < $request->seats_booked) {
            return response()->json(['message' => 'Not enough available seats'], 400);
        }

        $booking = BusBooking::create([
            'user_id' => $request->user_id,
            'bus_id' => $bus->id,
            'seats_booked' => $request->seats_booked,
        ]);

        // Update available seats
        $bus->decrement('available_seats', $request->seats_booked);

        return response()->json([
            'message' => 'Bus booked successfully',
            'booking' => $booking,
        ], 201);
    }

    // Get bookings of a user (user_id required as query param)
    public function myBookings(Request $request)
    {
        $request->validate([
            'user_id' => 'required|exists:users,id',
        ]);

        $bookings = BusBooking::with('bus')
            ->where('user_id', $request->user_id)
            ->whereDate('created_at', now()->toDateString())
            ->get();

        return response()->json(['bookings' => $bookings], 200);
    }

    // Cancel a booking (user_id required in request)
    public function cancel(Request $request, $id)
    {
        $request->validate([
            'user_id' => 'required|exists:users,id',
        ]);

        $booking = BusBooking::where('id', $id)
            ->where('user_id', $request->user_id)
            ->first();

        if (!$booking) {
            return response()->json(['message' => 'Booking not found'], 404);
        }

        $bus = $booking->bus;
        $bus->increment('available_seats', $booking->seats_booked);

        $booking->delete();

        return response()->json(['message' => 'Booking canceled successfully'], 200);
    }


// Update number of seats in a booking
public function update(Request $request, $id)
{
    $request->validate([
        'user_id' => 'required|exists:users,id',
        'seats_booked' => 'required|integer|min:1',
    ]);

    $booking = BusBooking::where('id', $id)
        ->where('user_id', $request->user_id)
        ->first();

    if (!$booking) {
        return response()->json(['message' => 'Booking not found'], 404);
    }

    $bus = $booking->bus;

    // Calculate seat difference
    $difference = $request->seats_booked - $booking->seats_booked;

    // If increasing seats, check availability
    if ($difference > 0 && $bus->available_seats < $difference) {
        return response()->json(['message' => 'Not enough available seats'], 400);
    }

    // Update seats on bus
    $bus->available_seats -= $difference;
    $bus->save();

    // Update booking
    $booking->seats_booked = $request->seats_booked;
    $booking->save();

    return response()->json([
        'message' => 'Booking updated successfully',
        'booking' => $booking,
    ], 200);
}







}


