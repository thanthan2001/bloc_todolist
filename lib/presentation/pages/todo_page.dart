import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_todo_test_v2/presentation/blocs/todo_bloc.dart';
import 'package:bloc_todo_test_v2/presentation/blocs/todo_event.dart';
import 'package:bloc_todo_test_v2/presentation/blocs/todo_state.dart';
import 'package:bloc_todo_test_v2/domain/entities/todo.dart';

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final todoBloc = context.read<TodoBloc>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Todos"),
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                if (state is TodoLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is TodoLoaded) {
                  final todos = state.todos;

                  return ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];

                      return ListTile(
                        title: Text(todo.title ?? ""),
                        subtitle: Text(todo.description ?? ""),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _showAddEditTodoDialog(
                                context,
                                todoBloc,
                                isEdit: true,
                                todo: todo,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                todoBloc.add(RemoveTodo(todo.id ?? 0));
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else if (state is TodoError) {
                  return Center(child: Text(state.message));
                }

                return const Center(child: Text("No todos available"));
              },
            ),
          ),
          Container(
            width: double.infinity,
            color: Colors.white,
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () => _showAddEditTodoDialog(context, todoBloc),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Màu nền
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0), // Bo góc
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 15.0), // Tăng độ cao nút
              ),
              child: const Text(
                "Add Todo",
                style: TextStyle(
                    fontSize: 16.0, color: Colors.white), // Chỉnh sửa font chữ
              ),
            ),
          )
        ],
      ),
    );
  }

  void _showAddEditTodoDialog(
    BuildContext context,
    TodoBloc todoBloc, {
    bool isEdit = false,
    Todo? todo,
  }) {
    final titleController =
        TextEditingController(text: isEdit ? todo?.title : "");
    final descriptionController =
        TextEditingController(text: isEdit ? todo?.description : "");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isEdit ? "Edit Todo" : "Add Todo"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: "Title"),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              final title = titleController.text.trim();
              final description = descriptionController.text.trim();

              if (title.isEmpty || description.isEmpty) return;

              if (isEdit) {
                // Edit existing todo
                todoBloc.add(EditTodo(
                  todo: Todo(
                    id: todo?.id,
                    title: title,
                    description: description,
                    isCompleted: todo?.isCompleted ?? false,
                  ),
                ));
              } else {
                // Add new todo
                todoBloc.add(AddTodo(
                  todo: Todo(
                    title: title,
                    description: description,
                    isCompleted: false,
                  ),
                ));
              }

              Navigator.of(context).pop();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
