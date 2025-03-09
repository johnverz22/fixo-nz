<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up() {
        Schema::create('profiles', function (Blueprint $table) {
            $table->id('profile_id');
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->tinyInteger('role'); // 1 = Homeowner, 2 = Tradie, 3 = Admin
            $table->text('bio')->nullable();
            $table->date('birthdate')->nullable();
            $table->string('address', 255)->nullable();
            $table->string('profile_picture', 255)->nullable();
            $table->timestamps();
        });
    }

    public function down() {
        Schema::dropIfExists('profiles');
    }
};
