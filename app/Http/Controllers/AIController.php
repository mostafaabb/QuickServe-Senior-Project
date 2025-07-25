<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use App\Models\Food;
use App\Models\Category;
use App\Models\Offer;
use App\Models\Bus;
use App\Models\PicnicPlace;
use App\Models\Driver;

class AIController extends Controller
{
    public function ask(Request $request)
    {
        $request->validate([
            'question' => 'required|string|max:2000',
        ]);

        try {
            // Foods
            $foods = Food::all(['name', 'description', 'price']);
            $menuText = "Here is our menu:\n";
            foreach ($foods as $food) {
                $menuText .= "- {$food->name}: {$food->description} (Price: {$food->price})\n";
            }

            // Categories
            $categories = Category::all(['name']);
            $categoryText = "\nCategories:\n";
            foreach ($categories as $category) {
                $categoryText .= "- {$category->name}\n";
            }

            // Offers — use your fields: title, description, discount, start_date, end_date, restaurant_id
            // Only include active offers (date filtering optional)
            $offers = Offer::where('start_date', '<=', now())
                            ->where('end_date', '>=', now())
                            ->get(['title', 'description', 'discount', 'restaurant_id']);
            $offerText = "\nCurrent Offers:\n";
            foreach ($offers as $offer) {
                $offerText .= "- {$offer->title}: {$offer->description} (Discount: {$offer->discount}%) from Restaurant ID: {$offer->restaurant_id}\n";
            }

            // Buses — use your fields: bus_number, driver_name, capacity, available_seats, departure_time, arrival_time, route
            $buses = Bus::where('departure_time', '>=', now())->get([
                'bus_number',
                'driver_name',
                'capacity',
                'available_seats',
                'departure_time',
                'arrival_time',
                'route'
            ]);
            $busText = "\nAvailable Buses:\n";
            foreach ($buses as $bus) {
                $busText .= "- Bus {$bus->bus_number} driven by {$bus->driver_name}: Capacity {$bus->capacity}, Available seats: {$bus->available_seats}, Departure: {$bus->departure_time}, Arrival: {$bus->arrival_time}, Route: {$bus->route}\n";
            }

             // ✅ Picnic Places
            $picnicPlaces = PicnicPlace::all(['name', 'location', 'description']);
            $picnicText = "\nPicnic Places:\n";
            foreach ($picnicPlaces as $place) {
                $picnicText .= "- {$place->name} in {$place->location}: {$place->description}\n";
            }

            // ✅ Drivers — name, phone, email, vehicle_type, vehicle_number, status
$drivers = Driver::all(['name', 'phone', 'email', 'vehicle_type', 'vehicle_number', 'status']);
$driverText = "\nDriver Directory:\n";
foreach ($drivers as $driver) {
    $driverText .= "- {$driver->name} | {$driver->vehicle_type} ({$driver->vehicle_number})\n";
    $driverText .= "  📞 Phone: {$driver->phone}, 📧 Email: {$driver->email}, ";
    $driverText .= "Status: " . ($driver->status ? 'Available ✅' : 'Unavailable ❌') . "\n";
}


            // Compose final prompt
            $systemPrompt = "You are a helpful assistant for a university food and transport app. Answer questions based on the following info:\n\n";
            $systemPrompt .= $menuText;
            $systemPrompt .= $categoryText;
            $systemPrompt .= $offerText;
            $systemPrompt .= $busText;
             $systemPrompt .= $picnicText;
             $systemPrompt .= $driverText;


            // Call OpenRouter API
            $response = Http::withHeaders([
                'Authorization' => 'Bearer ' . env('OPENROUTER_API_KEY'),
                'Content-Type' => 'application/json',
            ])
            ->timeout(60)
            ->post('https://openrouter.ai/api/v1/chat/completions', [
                'model' => 'deepseek/deepseek-r1:free',
                'messages' => [
                    [
                        'role' => 'system',
                        'content' => $systemPrompt
                    ],
                    [
                        'role' => 'user',
                        'content' => $request->question
                    ],
                ],
            ]);

            if ($response->failed()) {
                \Log::error('OpenRouter API returned an error:', $response->json());
                return response()->json([
                    'error' => 'OpenRouter API error',
                    'details' => $response->json(),
                ], $response->status());
            }

            $data = $response->json();

            if (isset($data['choices'][0]['message']['content'])) {
                return response()->json([
                    'answer' => trim($data['choices'][0]['message']['content']),
                ]);
            }

            return response()->json([
                'error' => 'No valid response from OpenRouter',
                'details' => $data,
            ], 500);

        } catch (\Exception $e) {
            \Log::error('OpenRouter AI error: ' . $e->getMessage());

            return response()->json([
                'error' => 'Failed to get AI response',
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
