<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Driver extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'phone',
        'email',
        'vehicle_type',
        'vehicle_number',
        'status',
    ];

    public function driverRequests()
{
    return $this->hasMany(DriverRequest::class, 'driver_id');
}
}
