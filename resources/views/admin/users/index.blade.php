@extends('admin.layout')

@section('content')
<div class="container my-4">
    <div class="card border-0 shadow-sm rounded bg-light">
        <div class="card-header bg-warning text-white">
            <h4 class="mb-0">👤 Users</h4>
        </div>

        <div class="card-body">
            <div class="table-responsive">
                <table class="table table-hover align-middle table-bordered">
                    <thead class="bg-warning text-white text-uppercase">
                        <tr>
                            <th>#</th>
                            <th>Name</th>
                            <th>Email</th>
                        </tr>
                    </thead>
                    <tbody>
                        @forelse($users as $user)
                            <tr>
                                <td>{{ $user->id }}</td>
                                <td>{{ $user->name }}</td>
                                <td>{{ $user->email }}</td>
                            </tr>
                        @empty
                            <tr>
                                <td colspan="3" class="text-center text-muted py-4">No users found.</td>
                            </tr>
                        @endforelse
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
@endsection
