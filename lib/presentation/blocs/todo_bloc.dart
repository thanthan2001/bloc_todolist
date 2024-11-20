import 'dart:math';

import 'package:bloc_todo_test_v2/domain/usecases/add_todo.dart';
import 'package:bloc_todo_test_v2/domain/usecases/edit_todo.dart';
import 'package:bloc_todo_test_v2/domain/usecases/get_todos.dart';
import 'package:bloc_todo_test_v2/domain/usecases/remove_todo.dart';
import 'package:bloc_todo_test_v2/presentation/blocs/todo_event.dart';
import 'package:bloc_todo_test_v2/presentation/blocs/todo_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodosUseCase getTodos;
  final AddTodoUseCase addTodo;
  final EditTodoUseCase editTodo;
  final RemoveTodoUseCase removeTodo;

  TodoBloc({
    required this.getTodos,
    required this.addTodo,
    required this.editTodo,
    required this.removeTodo,
  }) : super(TodoInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<EditTodo>(_onEditTodo);
    on<RemoveTodo>(_onRemoveTodo);
  }

  void _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    print("LOAD LOAD LOAD");
    try {
      final todos = await getTodos(event.startIndex, event.count);
      print("event.startIndex: ${event.startIndex}" +
          " event.count: ${event.count}");
      emit(TodoLoaded(todos: todos));
    } catch (e) {
      emit(TodoError(message: e.toString()));
    }
  }

  void _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    try {
      event.todo.id = DateTime.now().millisecondsSinceEpoch;
      await addTodo(event.todo);
      final todos = await getTodos(0, 10);
      emit(TodoLoaded(todos: todos));
    } catch (e) {
      emit(TodoError(message: e.toString()));
    }
  }

  void _onEditTodo(EditTodo event, Emitter<TodoState> emit) async {
    // Handle edit todo
  }
  // void _onRemoveTodo(RemoveTodo event, Emitter<TodoState> emit) async {
  //   print("REMOVE REMOVE REMOVE");
  //   try {
  //     await removeTodo(event.id);
  //     final todos = await getTodos(0, 10); // Adjust as needed
  //     emit(TodoLoaded(todos: todos));
  //   } catch (e) {
  //     emit(TodoError(message: e.toString()));
  //   }
  // }
  void _onRemoveTodo(RemoveTodo event, Emitter<TodoState> emit) async {
    try {
      // Xóa todo
      await removeTodo(event.id);

      // Lấy lại danh sách todos sau khi xóa
      final todos = await getTodos(0, 10); // Lấy lại danh sách todos từ index 0

      // Phát lại TodoLoaded với danh sách todos mới
      emit(TodoLoaded(todos: todos));
    } catch (e) {
      emit(TodoError(message: e.toString()));
    }
  }
}
