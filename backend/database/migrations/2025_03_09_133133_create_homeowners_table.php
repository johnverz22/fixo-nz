<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up() {
        Schema::create('homeowners', function (Blueprint $table) {
            $table->id('homeowner_id');
            $table->foreignId('user_id')->constrained('users')->onDelete('cascade');
            $table->date('birthdate')->nullable();
            $table->string('address', 255)->nullable();
            $table->string('contact_number', 20)->nullable();
            $table->string('occupation', 100)->nullable();
            $table->timestamps();
        });
    }

    public function down() {
        Schema::dropIfExists('homeowners');
    }
};
