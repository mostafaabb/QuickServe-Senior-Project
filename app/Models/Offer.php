<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Offer extends Model
{
    use HasFactory;

    protected $fillable = [
        'restaurant_id',
        'title',
        'description',
        'discount',
        'start_date',
        'end_date',
        'image', // stores path like "offers/image.jpg"
    ];

    public function restaurant()
    {
        return $this->belongsTo(Restaurant::class);
    }
    public $timestamps = true;
}
