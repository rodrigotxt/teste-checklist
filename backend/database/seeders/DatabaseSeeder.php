<?php

namespace Database\Seeders;

use App\Models\Tarefa;
use Illuminate\Database\Seeder;

class DatabaseSeeder extends Seeder
{
    /**
     * Seed the application's database.
     */
    public function run(): void
    {
        // Garante que a tabela está limpa antes de semear (evita duplicações)
        Tarefa::truncate();

        // Cria 10 tarefas fictícias usando a estrutura da Factory
        Tarefa::factory()->count(10)->create();

        $this->command->info('✨ Banco de dados MySQL semeado com 10 tarefas de exemplo!');
    }
}