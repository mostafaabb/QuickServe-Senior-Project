<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Order extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'food_id',
        'status',
        'total_price',         // match your DB column name here
        'delivery_address',
        'user_notes',    // use the exact DB column name here
    ];

    protected $casts = [
        'total_price' => 'float',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }

 // Order.php
public function foods()
{
    return $this->belongsToMany(Food::class, 'food_order')
                ->withPivot('quantity', 'price')
                ->withTimestamps();
}

}
