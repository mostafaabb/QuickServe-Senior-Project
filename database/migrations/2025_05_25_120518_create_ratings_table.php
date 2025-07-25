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
    Schema::create('ratings', function (Blueprint $table) {
        $table->id();
        $table->unsignedBigInteger('user_id')->nullable(); // If you track user ratings
        $table->tinyInteger('rating'); // 1 to 5 stars
        $table->text('comment')->nullable(); // Optional comment field
        $table->timestamps();

        // Foreign key if you want to link to users table
        $table->foreign('user_id')->references('id')->on('users')->onDelete('set null');
    });
}

};
