<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Homeowner;

class HomeownerController extends Controller {
    public function index() {
        return response()->json(Homeowner::all(), 200);
    }

    public function store(Request $request) {
        $homeowner = Homeowner::create($request->all());
        return response()->json($homeowner, 201);
    }

    public function show($id) {
        return response()->json(Homeowner::findOrFail($id), 200);
    }

    public function update(Request $request, $id) {
        $homeowner = Homeowner::findOrFail($id);
        $homeowner->update($request->all());
        return response()->json($homeowner, 200);
    }

    public function destroy($id) {
        Homeowner::findOrFail($id)->delete();
        return response()->json(null, 204);
    }
}
