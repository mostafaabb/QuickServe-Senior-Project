<?php

// app/Models/Admin.php

namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;

class Admin extends Authenticatable
{
    use Notifiable;

    // Optionally define the table name if it's different from the default
    protected $table = 'admins';  // Make sure this is correct

    // Optionally, define the fillable fields
    protected $fillable = [
        'name', 'email', 'password',
    ];

    // If using timestamps
    public $timestamps = true;

    // Optionally define hidden fields such as password
    protected $hidden = [
        'password', 'remember_token',
    ];

    // Optionally define attribute casting
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];
}
