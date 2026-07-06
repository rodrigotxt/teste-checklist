<?php

namespace Database\Factories;

use App\Models\Tarefa;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Tarefa>
 */
class TarefaFactory extends Factory
{
    protected $model = Tarefa::class;

    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        // Lista de verbos/ações comuns para tornar os títulos das tarefas muito realistas
        $acoes = [
            'Refatorar o módulo de', 'Corrigir bug crítico no', 'Revisar PR do',
            'Configurar pipeline de CI/CD para', 'Otimizar queries da tabela de',
            'Escrever testes unitários para', 'Atualizar dependências do',
            'Implementar autenticação no', 'Documentar os endpoints de'
        ];

        $componentes = ['Checkout', 'Painel Admin', 'API de Pagamentos', 'Componente Angular', 'Fila de Emails', 'Autenticação JWT'];

        $tituloAleatorio = $this->faker->randomElement($acoes) . ' ' . $this->faker->randomElement($componentes);

        return [
            'title' => $tituloAleatorio,
            'completed' => $this->faker->boolean(30), // 30% da tarefa já vir concluída
            'created_at' => $this->faker->dateTimeBetween('-1 month', 'now'),
            'updated_at' => function (array $attributes) {
                return $attributes['created_at'];
            },
        ];
    }
}