<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\PicnicPlace;

class PicnicPlaceController extends Controller
{
   public function index(Request $request)
{
    $query = PicnicPlace::query();

    if ($request->filled('search')) {
        $search = $request->search;
        $query->where('name', 'like', "%$search%")
              ->orWhere('location', 'like', "%$search%");
    }

    $places = $query->latest()->paginate(10);
    return view('admin.picnic_places.index', compact('places'));
}


    public function create()
    {
        return view('admin.picnic_places.create');
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required',
            'location' => 'required',
            'description' => 'nullable',
            'image' => 'nullable|image',
        ]);

        if ($request->hasFile('image')) {
            $validated['image'] = $request->file('image')->store('picnics', 'public');
        }

        PicnicPlace::create($validated);

        return redirect()->route('admin.picnic_places.index')->with('success', 'Picnic place added!');
    }

    public function edit($id)
    {
        $picnicPlace = PicnicPlace::findOrFail($id);
    return view('admin.picnic_places.edit', compact('picnicPlace'));
    }

    public function update(Request $request, $id)
    {
        $place = PicnicPlace::findOrFail($id);

        $validated = $request->validate([
            'name' => 'required',
            'location' => 'required',
            'description' => 'nullable',
            'image' => 'nullable|image',
        ]);

        if ($request->hasFile('image')) {
            $validated['image'] = $request->file('image')->store('picnics', 'public');
        }

        $place->update($validated);

        return redirect()->route('admin.picnic_places.index')->with('success', 'Updated!');
    }

    public function destroy($id)
    {
        $place = PicnicPlace::findOrFail($id);
        $place->delete();
        return redirect()->route('admin.picnic_places.index')->with('success', 'Deleted!');
    }
}

