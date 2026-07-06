<?php

namespace App\Http\Controllers;

use App\Http\Requests\StoreTarefaRequest;
use App\Models\Tarefa;
use Illuminate\Http\JsonResponse;

class TarefaController extends Controller
{
    /**
     * Listar todas as tarefas
     */
    public function index(): JsonResponse
    {
        $tarefas = Tarefa::orderBy('created_at', 'desc')->get();
        return response()->json($tarefas, 200);
    }

    /**
     * Criar uma nova tarefa com dados validados
     */
    public function store(StoreTarefaRequest $request): JsonResponse
    {
        $tarefa = Tarefa::create($request->validated());
        return response()->json($tarefa, 201);
    }

    /**
     * Excluir uma tarefa com verificação de existência resiliente
     */
    public function destroy(int $id): JsonResponse
    {
        $tarefa = Tarefa::find($id);

        if (!$tarefa) {
            return response()->json(['message' => 'Tarefa não encontrada.'], 404);
        }

        $tarefa->delete();
        return response()->json(null, 204); // Status 204 No Content = sucesso
    }
}