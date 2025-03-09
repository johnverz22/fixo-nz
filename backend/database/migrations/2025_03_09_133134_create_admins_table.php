<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up() {
        Schema::create('admins', function (Blueprint $table) {
            $table->id('admin_id');
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->date('birthdate')->nullable();
            $table->string('address', 255)->nullable();
            $table->string('contact_number', 20)->nullable();
            $table->timestamps();
        });
    }

    public function down() {
        Schema::dropIfExists('admins');
    }
};
