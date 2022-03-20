<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

// import controllers
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\QuestionController;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::get('/sub_categories/{parent_id}', [CategoryController::class, 'getSubCategories']);

Route::prefix('categories')->group(function () {
    Route::get('/', [CategoryController::class, 'getCategories']);
    Route::get('/all', [CategoryController::class, 'getAllCategories']);
});

Route::prefix('questions')->group(function () {
    Route::post('/', [QuestionController::class, 'store']);
    Route::post('/filtered', [QuestionController::class, 'getFiltered']);
    Route::post('/total_count', [QuestionController::class, 'totalCount']);
    Route::get('/complete/{id}', [QuestionController::class, 'complete']);
});
