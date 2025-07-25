<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Food extends Model
{
    use HasFactory;

    // 👇 Explicitly define the table name
    protected $table = 'food';

    protected $fillable = ['name', 'description', 'price', 'category_id', 'image'];

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function orders()
    {
       return $this->belongsToMany(Order::class, 'food_order')
                ->withPivot('quantity', 'price')
                ->withTimestamps();
    }
    public $timestamps = true;
}
