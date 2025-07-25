<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Bus extends Model
{
    protected $fillable = [
        'bus_number', 'driver_name', 'capacity',
        'available_seats', 'departure_time',
        'arrival_time', 'route',
    ];

    // 👇 Add this relationship
    public function bookings()
    {
        return $this->hasMany(BusBooking::class);
    }
}
