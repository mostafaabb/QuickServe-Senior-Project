<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Food Delivery</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <h1>Welcome to Our Food Delivery Service</h1>
        <h3>Available Foods</h3>
        <div class="row">
            @foreach ($foods as $food)
                <div class="col-md-4">
                    <div class="card">
                        <img src="{{ $food->image_url }}" class="card-img-top" alt="{{ $food->name }}">
                        <div class="card-body">
                            <h5 class="card-title">{{ $food->name }}</h5>
                            <p class="card-text">{{ $food->description }}</p>
                            <p class="card-text">${{ $food->price }}</p>
                            <a href="{{ route('foods.show', $food->id) }}" class="btn btn-primary">View Details</a>
                        </div>
                    </div>
                </div>
            @endforeach
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
