<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up()
{
    Schema::create('buses', function (Blueprint $table) {
        $table->id();
        $table->string('bus_number')->unique();
        $table->string('driver_name');
        $table->integer('capacity');
        $table->integer('available_seats');
        $table->time('departure_time');
        $table->time('arrival_time');
        $table->string('route')->nullable();
        $table->timestamps();
    });
}


    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('buses');
    }
};
