@extends('admin.layout')

@section('content')
<div class="container my-4">
    <div class="card shadow-sm">
        <div class="card-header bg-orange text-white d-flex justify-content-between align-items-center">
            <h3 class="mb-0">User Ratings</h3>
        </div>
        <div class="card-body p-0">
            <div class="table-responsive">
                <table class="table table-striped table-hover mb-0">
                    <thead class="bg-orange-light text-orange-dark text-uppercase">
                        <tr>
                            <th>ID</th>
                            <th>User</th>
                            <th>Rating</th>
                            <th>Comment</th>
                            <th>Submitted At</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($ratings as $rating)
                        <tr>
                            <td>{{ $rating->id }}</td>
                            <td>{{ $rating->user->name ?? 'Unknown' }}</td>
                            <td>
                                <span class="fw-bold">{{ $rating->rating }}</span> / 5
                            </td>
                            <td>{{ $rating->comment ?? '-' }}</td>
                            <td>{{ $rating->created_at->format('Y-m-d H:i') }}</td>
                        </tr>
                        @empty
                        <tr>
                            <td colspan="5" class="text-center text-muted py-4">No ratings found.</td>
                        </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
        <div class="card-footer d-flex justify-content-center">
            {{ $ratings->links() }}
        </div>
    </div>
</div>

<style>
    /* Orange color palette */
    .bg-orange {
        background-color: #fb6f33 !important;
    }
    .bg-orange-light {
        background-color: #fedac1 !important;
    }
    .text-orange-dark {
        color: #b34700 !important;
    }
</style>
@endsection
