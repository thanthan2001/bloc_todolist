import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class EditTodoUseCase {
  final TodoRepository repository;

  EditTodoUseCase(this.repository);

  Future<void> call(Todo todo) async {
    return repository.editTodo(todo);
  }
}
