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
        Schema::create('offers', function (Blueprint $table) {
            $table->id();
            // $table->foreignId('restaurant_id')->constrained()->onDelete('cascade');
            $table->string('title');
            $table->text('description')->nullable();
           $table->decimal('discount', 5, 2)->nullable(); // 5 digits with 2 decimal places
            $table->date('start_date');
            $table->date('end_date');
            $table->timestamps();
        });
    }
    
    

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('offers');
    }
};
