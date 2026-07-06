import { Injectable, signal, computed, inject } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Observable, catchError, of, tap } from 'rxjs';
import { Todo, CreateTodoDto } from '../models/todo.model';

@Injectable({
  providedIn: 'root'
})
export class TodoService {
  private readonly http = inject(HttpClient);
  private readonly apiUrl = 'http://localhost:8000/api/tarefas';

  // Estado reativo privado interno
  #todosSignal = signal<Todo[]>([]);

  // Exposição pública apenas para leitura
  readonly todos = computed(() => this.#todosSignal());

  /**
   * Busca a lista de tarefas da API
   */
  findAll(): Observable<Todo[]> {
    return this.http.get<Todo[]>(this.apiUrl).pipe(
      tap(todos => this.#todosSignal.set(todos)),
      catchError(error => {
        console.error('Erro ao carregar tarefas da API, ativando fallback offline:', error);
        // Fallback direto na camada de dados
        const fallbackTodos: Todo[] = [
          { id: 1, title: 'Tarefa offline 1 (Fallback)', completed: false },
          { id: 2, title: 'Tarefa offline 2 (Fallback)', completed: true }
        ];
        this.#todosSignal.set(fallbackTodos);
        return of(fallbackTodos);
      })
    );
  }

  /**
   * Cadastra uma nova tarefa
   */
  create(dto: CreateTodoDto): Observable<Todo> {
    return this.http.post<Todo>(this.apiUrl, dto).pipe(
      tap(newTodo => {
        this.#todosSignal.update(todos => [...todos, newTodo]);
      }),
      catchError(error => {
        console.error('Erro ao salvar no servidor, gerando registro local temporário:', error);
        const fakeTodo: Todo = {
          id: Math.floor(Math.random() * 1000),
          title: dto.title,
          completed: false
        };
        this.#todosSignal.update(todos => [...todos, fakeTodo]);
        return of(fakeTodo);
      })
    );
  }

  /**
   * Remove uma tarefa pelo ID
   */
  delete(id: number): Observable<void> {
    return this.http.delete<void>(`${this.apiUrl}/${id}`).pipe(
      tap(() => {
        this.#todosSignal.update(todos => todos.filter(t => t.id !== id));
      }),
      catchError(error => {
        console.error(`Erro ao deletar tarefa ${id}:`, error);
        this.#todosSignal.update(todos => todos.filter(t => t.id !== id));
        return of(void 0);
      })
    );
  }
}