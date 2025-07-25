<?php

// app/Models/Reward.php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Reward extends Model
{
    use HasFactory;

    protected $fillable = [
        'user_id',
        'title',
        'code',
        'discount_amount',
        'used',
    ];

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
