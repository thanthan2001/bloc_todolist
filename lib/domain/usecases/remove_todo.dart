import '../repositories/todo_repository.dart';

class RemoveTodoUseCase {
  final TodoRepository repository;

  RemoveTodoUseCase(this.repository);

  Future<void> call(int id) async {
    return repository.removeTodo(id);
  }
}
