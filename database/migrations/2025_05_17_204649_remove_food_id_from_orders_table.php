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
    Schema::table('orders', function (Blueprint $table) {
        // Drop foreign key constraint first
        $table->dropForeign(['food_id']);
        
        // Then drop the column
        $table->dropColumn('food_id');
    });
}

public function down()
{
    Schema::table('orders', function (Blueprint $table) {
        $table->unsignedBigInteger('food_id')->nullable();
        $table->foreign('food_id')->references('id')->on('food')->onDelete('cascade');
    });
}

};
