// todo_event.dart
import 'package:equatable/equatable.dart';

import '../../domain/entities/todo.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

class LoadTodos extends TodoEvent {
  final int startIndex;
  final int count;

  const LoadTodos(this.startIndex, this.count);

  @override
  List<Object> get props => [startIndex, count];
}

class AddTodo extends TodoEvent {
  final Todo todo;

  const AddTodo({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];
}

class EditTodo extends TodoEvent {
  final Todo todo;

  const EditTodo({
    required this.todo,
  });

  @override
  List<Object> get props => [todo];
}

class RemoveTodo extends TodoEvent {
  final int id;

  const RemoveTodo(this.id);

  @override
  List<Object> get props => [id];
}
