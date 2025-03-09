<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tradie extends Model {
    use HasFactory;

    protected $primaryKey = 'tradie_id';
    protected $fillable = ['user_id', 'birthdate', 'address', 'contact_number', 'occupation'];

    public function user() {
        return $this->belongsTo(User::class, 'user_id');
    }
}
