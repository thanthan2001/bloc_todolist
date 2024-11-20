import '../entities/todo.dart';

abstract class TodoRepository {
  Future<List<Todo>> getTodos(int page, int limit);
  Future<void> addTodo(Todo todo);
  Future<void> editTodo(Todo todo);
  Future<void> removeTodo(int id);
}
