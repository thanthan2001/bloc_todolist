import 'package:objectbox/objectbox.dart';

import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final Store store;

  TodoRepositoryImpl(this.store);

  @override
  Future<List<Todo>> getTodos(int page, int limit) async {
    final box = store.box<TodoModel>();
    final query = box.query().build();
    query.offset = page * limit;
    query.limit = limit;
    final models = query.find();
    return models
        .map((model) => Todo(
              id: model.id,
              title: model.title,
              description: model.description,
              isCompleted: model.isCompleted,
            ))
        .toList();
  }

  @override
  Future<void> addTodo(Todo todo) async {
    final box = store.box<TodoModel>();
    final model = TodoModel(
      title: todo.title ?? '',
      description: todo.description ?? '',
      isCompleted: todo.isCompleted ?? false,
    );
    box.put(model);
  }

  @override
  Future<void> editTodo(Todo todo) async {
    final box = store.box<TodoModel>();
    final model = TodoModel(
      id: todo.id ?? 0,
      title: todo.title ?? '',
      description: todo.description ?? '',
      isCompleted: todo.isCompleted ?? false,
    );
    box.put(model);
  }

  @override
  Future<void> removeTodo(int id) async {
    final box = store.box<TodoModel>();
    box.remove(id);
  }
}
