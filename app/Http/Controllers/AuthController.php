<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class AuthController extends Controller
{
    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required|string',
            'email' => 'required|email|unique:users',
            'password' => 'required|confirmed|string|min:6'
        ]);

        $user = User::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password)
        ]);
        $user->save();

        $token = $user->createToken('auth_token')->plainTextToken;

        return response()->json([
        
            'user' => $user,
            'access_token' => $token,
            // 'token_type' => 'Bearer',
        ]);
    }
}
