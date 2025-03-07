<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Laravel\Socialite\Facades\Socialite;
use App\Models\User;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\Auth;

class OAuthController extends Controller
{
    // Redirect to Provider (Google, GitHub, Facebook)
    public function redirect($provider)
    {
        return Socialite::driver($provider)->stateless()->redirect();
    }

    // Handle Callback
    public function callback($provider)
    {
        try {
            $socialUser = Socialite::driver($provider)->stateless()->user();

            // Find or create user
            $user = User::updateOrCreate([
                'email' => $socialUser->getEmail(),
            ], [
                'firstname' => $socialUser->getName(),
                'lastname' => '',
                'username' => $socialUser->getNickname() ?? Str::slug($socialUser->getName()),
                'password' => Hash::make(Str::random(16)), // Set a random password
                'role' => 'homeowner', // Default role
            ]);

            // Generate Sanctum token
            $token = $user->createToken('auth_token')->plainTextToken;

            return response()->json([
                'message' => 'Login successful',
                'user' => $user,
                'token' => $token,
            ]);
        } catch (\Exception $e) {
            return response()->json(['error' => 'OAuth login failed'], 500);
        }
    }
}
