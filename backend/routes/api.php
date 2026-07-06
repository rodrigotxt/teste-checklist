<?php

use App\Http\Controllers\TarefaController;
use Illuminate\Support\Facades\Route;

// Rotas limpas e mapeadas para o Controller
Route::get('/tarefas', [TarefaController::class, 'index']);
Route::post('/tarefas', [TarefaController::class, 'store']);
Route::delete('/tarefas/{id}', [TarefaController::class, 'destroy'])->whereNumber('id');