<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Profile extends Model {
    use HasFactory;

    protected $primaryKey = 'profile_id';
    protected $fillable = ['user_id', 'role', 'bio', 'birthdate', 'address', 'profile_picture'];

    public function user() {
        return $this->belongsTo(User::class, 'user_id');
    }
}

