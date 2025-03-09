<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Admin;

class AdminController extends Controller {
    public function index() {
        return response()->json(Admin::all(), 200);
    }

    public function store(Request $request) {
        $admin = Admin::create($request->all());
        return response()->json($admin, 201);
    }

    public function show($id) {
        return response()->json(Admin::findOrFail($id), 200);
    }

    public function update(Request $request, $id) {
        $admin = Admin::findOrFail($id);
        $admin->update($request->all());
        return response()->json($admin, 200);
    }

    public function destroy($id) {
        Admin::findOrFail($id)->delete();
        return response()->json(null, 204);
    }
}
