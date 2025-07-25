<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddMissingColumnsToOrdersTable extends Migration
{
    public function up()
    {
        Schema::table('orders', function (Blueprint $table) {
            if (!Schema::hasColumn('orders', 'food_id')) {
                $table->foreignId('food_id')->constrained()->after('user_id')->onDelete('cascade');
            }
            if (!Schema::hasColumn('orders', 'total_price')) {
                $table->decimal('total_price', 8, 2)->after('status');
            }
            if (!Schema::hasColumn('orders', 'delivery_address')) {
                $table->string('delivery_address')->after('total_price');
            }
        });
    }

    public function down()
    {
        Schema::table('orders', function (Blueprint $table) {
            if (Schema::hasColumn('orders', 'delivery_address')) {
                $table->dropColumn('delivery_address');
            }
            if (Schema::hasColumn('orders', 'total_price')) {
                $table->dropColumn('total_price');
            }
            if (Schema::hasColumn('orders', 'food_id')) {
                $table->dropForeign(['food_id']);
                $table->dropColumn('food_id');
            }
        });
    }
}
