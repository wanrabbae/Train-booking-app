<?php

use App\Http\Controllers\BookingCtrl;
use App\Http\Controllers\CustomerCtrl;
use App\Http\Controllers\DashboardCtrl;
use App\Http\Controllers\NewsCtrl;
use App\Http\Controllers\TrainCtrl;
use App\Http\Controllers\UserCtrl;
use App\Http\Controllers\WagonCtrl;
use App\Models\Customer;
use App\Models\News;
use App\Models\Train;
use App\Models\TrainFare;
use App\Models\TrainJourney;
use App\Models\TrainRoute;
use App\Models\TrainStation;
use App\Models\User;
use App\Models\Wagon;
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

// NEWS
Route::get('/news', function () {
    return view('news.index', [
        "title" => "KAI News",
        "news" => News::all()
    ]);
})->name("news");
Route::post('/news/add', [NewsCtrl::class, 'store']);
Route::post('/news/update/{id}', [NewsCtrl::class, 'update']);
Route::get('/news/delete/{id}', [NewsCtrl::class, 'destroy']);
Route::get('/news/{id}/publish', [NewsCtrl::class, 'publish']);
Route::get('/news/{id}/unpublish', [NewsCtrl::class, 'unpublish']);

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
Route::get('/', [DashboardCtrl::class, 'index'])->name("dashboard")->middleware('auth');

// TRAINS
Route::prefix("/trains")->middleware('auth')->group(function () {
    Route::get('/', function () {
        return view('train.index', [
            "title" => "KAI Trains",
            "trains" => Train::all(),
            "train_fares" => TrainFare::all()
        ]);
    })->name("trains");

    Route::post("/add", [TrainCtrl::class, 'addTrain']);
    Route::post("/update/{id}", [TrainCtrl::class, 'updateTrain']);
    Route::get("/delete/{id}", [TrainCtrl::class, 'deleteTrain']);

    Route::get('/{id}/wagon', function ($id) {
        $train = Train::find($id);
        $fares = TrainFare::where('train_no', $train->train_no)->get();
        return view('train.wagon', [
            "title" => $train->train_name,
            "id_train" => $train->id,
            "fares" => $fares,
            "wagons" => Wagon::with(['wagon_seat', 'train_fare'])->where('train_id', $id)->get()
        ]);
    })->name("trains_wagon");

    Route::post("/wagon/add", [WagonCtrl::class, 'addWagon']);
    Route::post("/wagon/update/{id}", [WagonCtrl::class, 'updateWagon']);
    Route::get("/wagon/delete/{id}", [WagonCtrl::class, 'deleteWagon']);

    Route::get('/wagon/{id}/passengers', function ($id) {
        return view('train.wagon_detail', [
            "title" => "Train Passenger",
            "wagons" => Wagon::with(['wagon_seat', 'wagon_seat.passenger'])->where('id', $id)->get()
        ]);
    })->name("trains_wagon_detail");
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
Route::prefix("/trains/journey")->middleware('auth')->group(function () {
    Route::get('/', function () {
        return view('train_journey.index', [
            "title" => "KAI Train Journey",
            "train_journeys" => TrainJourney::with(['train', 'train_station_depart', 'train_station_arrival'])->get(),
            "train_station" => TrainStation::all(),
            "trains" => Train::all(),
            "train_fares" => TrainFare::all(),
        ]);
    })->name("trains_journey");
    Route::post("/add", [TrainCtrl::class, 'addTrainJourney']);
    Route::post("/update/{id}", [TrainCtrl::class, 'updateTrainJourney']);
    Route::get("/delete/{id}", [TrainCtrl::class, 'deleteTrainJourney']);
});

// TRAINS ROUTE
Route::prefix("/trains/route")->middleware('auth')->group(function () {
    Route::get('/', function () {
        return view('train_route.index', [
            "title" => "KAI Train Routes",
            "train_routes" => TrainRoute::with(['train_station_start', 'train_station_end'])->get(),
            "train_fares" => TrainFare::all(),
            "trains" => Train::all(),
            "train_station" => TrainStation::all(),
        ]);
    })->name("trains_route");
    Route::post("/add", [TrainCtrl::class, 'addTrainRoute']);
    Route::post("/update/{id}", [TrainCtrl::class, 'updateTrainRoute']);
    Route::get("/delete/{id}", [TrainCtrl::class, 'deleteTrainRoute']);
});

// TRAIN FARE
Route::prefix("/trains/fare")->middleware('auth')->group(function () {
    Route::get('/', function () {
        return view('train_fare.index', [
            "title" => "KAI Train Fare",
            "trains" => Train::all(),
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
Route::get('/booking', [BookingCtrl::class, 'getData'])->name("booking")->middleware('auth');;
Route::put('/booking', [BookingCtrl::class, 'updateStatus'])->name("updateStatusBooking")->middleware('auth');;
