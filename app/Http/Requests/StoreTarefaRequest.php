<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreTarefaRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true; // Aberto somente para o escopo do teste
    }

    public function rules(): array
    {
        return [
            'title' => ['required', 'string', 'min:3', 'max:255'],
        ];
    }

    public function messages(): array
    {
        return [
            'title.required' => 'O título da tarefa é obrigatório.',
            'title.min' => 'O título deve conter pelo menos 3 caracteres.',
        ];
    }
}