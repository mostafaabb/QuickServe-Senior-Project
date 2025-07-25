<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Category extends Model
{
    use HasFactory;

    // Mass assignable fields
    protected $fillable = [
        'name',
        'description',
        'image',
    ];

    // Define relationship to foods (if any)
    public function foods()
    {
        return $this->hasMany(Food::class);
    }
     public $timestamps = true;
}
