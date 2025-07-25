<?php

namespace App\Http\Controllers\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\PicnicPlace;
use Illuminate\Support\Facades\Validator;

class PicnicPlaceController extends Controller
{
    public function index()
    {
        return response()->json(PicnicPlace::all());
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:255',
            'location' => 'required|string',
            'description' => 'nullable|string',
            'image' => 'nullable|image|mimes:jpeg,png,jpg,gif',
        ]);

        if ($validator->fails()) {
            return response()->json(['error' => $validator->errors()], 422);
        }

        $data = $request->all();

        if ($request->hasFile('image')) {
            $data['image'] = $request->file('image')->store('picnics', 'public');
        }

        $place = PicnicPlace::create($data);
        return response()->json(['message' => 'Created successfully', 'data' => $place], 201);
    }

    public function show($id)
    {
        return response()->json(PicnicPlace::findOrFail($id));
    }

    public function update(Request $request, $id)
    {
        $place = PicnicPlace::findOrFail($id);

        $data = $request->only(['name', 'location', 'description']);

        if ($request->hasFile('image')) {
            $data['image'] = $request->file('image')->store('picnics', 'public');
        }

        $place->update($data);

        return response()->json(['message' => 'Updated successfully', 'data' => $place]);
    }

    public function destroy($id)
    {
        $place = PicnicPlace::findOrFail($id);
        $place->delete();

        return response()->json(['message' => 'Deleted successfully']);
    }
}

