<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    // Register
    public function register(Request $request)
    {
        $request->validate([
            'firstname' => 'required|string|max:100',
            'lastname' => 'required|string|max:100',
            'email' => 'required|string|email|max:150|unique:users',
            'username' => 'required|string|max:50|unique:users',
            'password' => 'required|string|min:8',
            'role' => 'integer|in:1,2,3',
        ]);

        $user = User::create([
            'firstname' => $request->firstname,
            'lastname' => $request->lastname,
            'email' => $request->email,
            'username' => $request->username,
            'password' => Hash::make($request->password),
            'role' => $request->role ?? 1, // Default to Homeowner
        ]);

        $token = $user->createToken('authToken')->plainTextToken;

        return response()->json(['token' => $token, 'user' => $user], 201);
    }

    // Login
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);
    
        $user = User::where('email', $request->email)->first();
    
        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json(['message' => 'Invalid credentials'], 401);
        }
    
        // Additional logging to check the user object
        \Log::info('User object', ['user' => $user]);
    
        // Debug statement to check the user object
        if (!$user->id) {
            \Log::error('User ID is null', ['user' => $user, 'user_id' => $user->id, 'user_email' => $user->email]);
            return response()->json(['message' => 'User ID is null'], 500);
        }
    
        // Generate a token
        $token = $user->createToken('authToken')->plainTextToken;
    
        return response()->json([
            'user' => $user,
            'token' => $token
        ], 200);
    }

    // Logout
    public function logout(Request $request)
    {
        $request->user()->tokens()->delete();
        return response()->json(['message' => 'Logged out'], 200);
    }
}

