import { Component, OnInit, inject, signal } from '@angular/core';
import { RouterOutlet } from '@angular/router';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { TodoService } from './services/todo.service';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [RouterOutlet, CommonModule, FormsModule],
  templateUrl: './app.component.html',
  styleUrl: './app.component.scss'
})
export class AppComponent implements OnInit {
  private readonly todoService = inject(TodoService);

  title = 'Todo List';
  
  // Estado local para o formulário controlado por Signal para melhor performance de renderização
  newTodoTitle = signal<string>('');

  // Atalho para consumir a lista reativa do serviço
  readonly todos = this.todoService.todos;

  ngOnInit(): void {
    // Dispara a busca inicial.
    // fluxo interno do HTTP e Signals cuida do ciclo de vida.
    this.todoService.findAll().subscribe();
  }

  addTodo(): void {
    const titleClean = this.newTodoTitle().trim();
    if (!titleClean) return;

    this.todoService.create({ title: titleClean }).subscribe({
      next: () => this.newTodoTitle.set('') // Reseta o campo de input
    });
  }

  removeTodo(id: number | undefined): void {
    if (id === undefined) return;
    
    this.todoService.delete(id).subscribe();
  }
}