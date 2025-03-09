<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Admin extends Model {
    use HasFactory;

    protected $primaryKey = 'admin_id';
    protected $fillable = ['user_id', 'birthdate', 'address', 'contact_number'];

    public function user() {
        return $this->belongsTo(User::class, 'user_id');
    }
}

