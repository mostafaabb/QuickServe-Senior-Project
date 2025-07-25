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
    Schema::table('offers', function (Blueprint $table) {
        $table->foreignId('restaurant_id')->constrained('restaurants')->onDelete('cascade');
    });
}

public function down()
{
    Schema::table('offers', function (Blueprint $table) {
        $table->dropForeign(['restaurant_id']);
        $table->dropColumn('restaurant_id');
    });
}

};
