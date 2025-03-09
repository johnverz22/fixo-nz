<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Tradie;

class TradieController extends Controller {
    public function index() {
        return response()->json(Tradie::all(), 200);
    }

    public function store(Request $request) {
        $tradie = Tradie::create($request->all());
        return response()->json($tradie, 201);
    }

    public function show($id) {
        return response()->json(Tradie::findOrFail($id), 200);
    }

    public function update(Request $request, $id) {
        $tradie = Tradie::findOrFail($id);
        $tradie->update($request->all());
        return response()->json($tradie, 200);
    }

    public function destroy($id) {
        Tradie::findOrFail($id)->delete();
        return response()->json(null, 204);
    }
}
