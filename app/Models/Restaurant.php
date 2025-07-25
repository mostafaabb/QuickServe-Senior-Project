<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Restaurant extends Model
{
    use HasFactory;

    protected $fillable = [
        'name', 'location', 'email', 'contact', 'description', 'image', 'hours',
    ];

public function offers()
{
    return $this->hasMany(Offer::class);
}

}