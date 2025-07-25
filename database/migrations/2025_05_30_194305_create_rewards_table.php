<?php

// database/migrations/xxxx_xx_xx_create_rewards_table.php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('rewards', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->onDelete('cascade');
            $table->string('title'); // e.g., “Won Food Quiz”
            $table->string('code')->unique(); // e.g., DISCOUNT10
            $table->decimal('discount_amount', 8, 2)->nullable(); // e.g., 10.00 = 10% off
            $table->boolean('used')->default(false);
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('rewards');
    }
};
