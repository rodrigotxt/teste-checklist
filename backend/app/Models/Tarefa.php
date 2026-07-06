<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tarefa extends Model
{
    use HasFactory;

    protected $table = 'tarefas';

    // Mass assignment control
    protected $fillable = [
        'title',
        'completed',
    ];

    // Casts automáticos para garantir tipagem rígida na API
    protected $casts = [
        'completed' => 'boolean',
    ];
}