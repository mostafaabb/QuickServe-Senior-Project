<?php

return [

    /*
    |---------------------------------------------------------------------------
    | Laravel CORS Configuration
    |---------------------------------------------------------------------------
    |
    | Here you may configure your settings for handling cross-origin requests.
    | You can modify these settings to enable CORS based on your requirements.
    | By default, Laravel will allow requests from any origin, but it is
    | recommended to restrict this in production to a specific set of domains.
    |
    */

    'paths' => ['api/*'],  // Allow CORS for all API routes

    'allowed_methods' => ['*'], // Allow all HTTP methods (GET, POST, PUT, DELETE, etc.)

    'allowed_origins' => [
        'http://localhost:3000',  // For frontend in development
        'http://127.0.0.1:8000',  // Local testing URL
        // 'http://yourfrontend.com',  // Production frontend URL
    ], 

    'allowed_origins_patterns' => [],

    'allowed_headers' => [
        'Content-Type',
        'Authorization',
        'X-Requested-With',
        'Accept',
        'Origin',
    ],

    'exposed_headers' => [], // Expose specific headers to the client (if needed)

    'max_age' => 3600, // Cache CORS preflight requests for 1 hour

    'supports_credentials' => false, // Set to true if you want to allow cookies or other credentials

];
