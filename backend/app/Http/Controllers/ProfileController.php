<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Profile;

class ProfileController extends Controller {
    public function index() {
        return response()->json(Profile::all(), 200);
    }

    public function store(Request $request) {
        $profile = Profile::create($request->all());
        return response()->json($profile, 201);
    }

    public function show($id) {
        return response()->json(Profile::findOrFail($id), 200);
    }

    public function update(Request $request, $id) {
        $profile = Profile::findOrFail($id);
        $profile->update($request->all());
        return response()->json($profile, 200);
    }

    public function destroy($id) {
        Profile::findOrFail($id)->delete();
        return response()->json(null, 204);
    }
}
