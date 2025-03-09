<?php

use App\Http\Controllers\AuthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use Laravel\Socialite\Facades\Socialite;
use App\Models\User;
use Kreait\Firebase\Auth;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\HomeownerController;
use App\Http\Controllers\TradieController;
use App\Http\Controllers\AdminController;

// Routes for Profile, Homeowner, Tradie, and Admin
Route::apiResource('profiles', ProfileController::class);
Route::apiResource('homeowners', HomeownerController::class);
Route::apiResource('tradies', TradieController::class);
Route::apiResource('admins', AdminController::class);

// Route for Firebase SMS Login with Laravel Sanctum not working yet
Route::post('/auth/firebase-sms-login', function (Request $request, Auth $firebaseAuth) {
    $request->validate(['idToken' => 'required']);

    try {
        $verifiedIdToken = $firebaseAuth->verifyIdToken($request->idToken);
        $uid = $verifiedIdToken->claims()->get('sub');
        $firebaseUser = $firebaseAuth->getUser($uid);

        $user = User::updateOrCreate([
            'email' => $firebaseUser->phoneNumber, 
        ], [
            'firstname' => 'Firebase User',
            'lastname' => '',
            'email' => $firebaseUser->phoneNumber,
            'password' => bcrypt('firebasepassword'),
        ]);

        $token = $user->createToken('authToken')->plainTextToken;

        return response()->json([
            'user' => $user,
            'token' => $token
        ]);
    } catch (\Exception $e) {
        return response()->json(['error' => 'Invalid Firebase ID Token'], 401);
    }
});


Route::get('auth/{provider}', function ($provider) {
    return Socialite::driver($provider)->stateless()->redirect();
});

Route::get('auth/{provider}/callback', function ($provider) {
    $socialUser = Socialite::driver($provider)->stateless()->user();

    $user = User::updateOrCreate(
        ['email' => $socialUser->getEmail()],
        [
            'firstname' => $socialUser->getName(),
            'username' => $socialUser->getNickname() ?? $socialUser->getEmail(),
            'password' => bcrypt(uniqid()),
        ]
    );

    $token = $user->createToken('authToken')->plainTextToken;

    return response()->json([
        'user' => $user,
        'token' => $token
    ]);
});

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->group(function () {
    Route::post('/logout', [AuthController::class, 'logout']);
    Route::get('/user', function (Request $request) {
        return response()->json($request->user());
    });
});
