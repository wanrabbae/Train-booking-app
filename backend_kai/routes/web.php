<?php

use App\Http\Controllers\CustomerCtrl;
use App\Http\Controllers\TrainCtrl;
use App\Http\Controllers\UserCtrl;
use App\Models\Customer;
use App\Models\Train;
use App\Models\TrainFare;
use App\Models\TrainStation;
use App\Models\User;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/
// LOGIN
Route::get('/login', function () {
    return view('auth.login', [
        "title" => "KAI Login"
    ]);
})->name("login");
Route::get('/logout', [UserCtrl::class, 'logout'])->name("logout");
Route::post("/login", [UserCtrl::class, 'auth']);

// USERS
Route::prefix("/users")->middleware('auth')->group(function () {
    Route::get('/', function () {
        return view('users.index', [
            "title" => "KAI Pengguna Sistem",
            "users" => User::all()
        ]);
    })->name("users");
    Route::post("/add", [UserCtrl::class, 'addUser']);
    Route::post("/update/{id}", [UserCtrl::class, 'updateUser']);
    Route::get("/delete/{id}", [UserCtrl::class, 'deleteUser']);
});


// DASHBOARD
Route::get('/', function () {
    return view('index', [
        "title" => "KAI Dashboard"
    ]);
})->name("dashboard")->middleware('auth');

// TRAINS
Route::prefix("/trains")->middleware('auth')->group(function () {
    Route::get('/', function () {
        return view('train.index', [
            "title" => "KAI Trains",
            "trains" => Train::all()
        ]);
    })->name("trains");
    Route::post("/add", [TrainCtrl::class, 'addTrain']);
    Route::post("/update/{id}", [TrainCtrl::class, 'updateTrain']);
    Route::get("/delete/{id}", [TrainCtrl::class, 'deleteTrain']);
});

// TRAIN STATIONS
Route::prefix("/train_station")->middleware('auth')->group(function () {
    Route::get('/', function () {
        return view('train_station.index', [
            "title" => "KAI Train Station",
            "train_station" => TrainStation::all()
        ]);
    })->name("train_station");
    Route::post("/add", [TrainCtrl::class, 'addTrainStation']);
    Route::post("/update/{id}", [TrainCtrl::class, 'updateTrainStation']);
    Route::get("/delete/{id}", [TrainCtrl::class, 'deleteTrainStation']);
});

// TRAINS JOURNEY
Route::get('/trains/journey', function () {
    return view('train_journey.index', [
        "title" => "KAI Journey"
    ]);
})->name("trains_journey")->middleware('auth');

// TRAINS ROUTE
Route::get('/trains/route', function () {
    return view('train_route.index', [
        "title" => "KAI Route"
    ]);
})->name("trains_route")->middleware('auth');

// TRAIN FARE
Route::prefix("/trains/fare")->middleware('auth')->group(function () {
    Route::get('/', function () {
        return view('train_fare.index', [
            "title" => "KAI Train Fare",
            "train_fares" => TrainFare::all()
        ]);
    })->name("trains_fare");
    Route::post("/add", [TrainCtrl::class, 'addTrainFare']);
    Route::post("/update/{id}", [TrainCtrl::class, 'updateTrainFare']);
    Route::get("/delete/{id}", [TrainCtrl::class, 'deleteTrainFare']);
});

// CUSTOMER
Route::prefix("/customers")->middleware('auth')->group(function () {
    Route::get('/', function () {
        return view('customer.index', [
            "title" => "KAI Customer",
            "customers" => Customer::all()
        ]);
    })->name("customers");
    Route::post("/add", [CustomerCtrl::class, 'addCustomer']);
    Route::post("/update/{id}", [CustomerCtrl::class, 'updateCustomer']);
    Route::get("/delete/{id}", [CustomerCtrl::class, 'deleteCustomer']);
});

// BOOKING DATA
Route::get('/booking', function () {
    return view('booking.index', [
        "title" => "KAI booking"
    ]);
})->name("booking")->middleware('auth');;
