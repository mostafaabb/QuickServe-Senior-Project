<?php

// app/Models/DriverRequest.php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class DriverRequest extends Model
{
    use HasFactory;

   protected $fillable = [
    'user_id',
    'driver_id',
    'description',
    'pickup_location',
    'dropoff_location',
    'status',
    'price',
];

public function user()
{
    return $this->belongsTo(User::class, 'user_id');
}

public function driver()
{
    return $this->belongsTo(Driver::class, 'driver_id');
}

}
