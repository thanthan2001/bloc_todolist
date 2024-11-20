import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';

import 'data/repositories/todo_repository_impl.dart';
import 'domain/repositories/todo_repository.dart';
import 'domain/usecases/add_todo.dart';
import 'domain/usecases/edit_todo.dart';
import 'domain/usecases/get_todos.dart';
import 'domain/usecases/remove_todo.dart';
import 'objectbox.g.dart';
import 'presentation/blocs/todo_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  // Register ObjectBox
  final directory = await getApplicationDocumentsDirectory();
  final store = await openStore(directory: directory.path);
  getIt.registerSingleton<Store>(store);

  // Register repositories
  getIt.registerLazySingleton<TodoRepository>(() => TodoRepositoryImpl(store));

  // Register use cases
  getIt.registerLazySingleton(() => AddTodoUseCase(getIt()));
  getIt.registerLazySingleton(() => EditTodoUseCase(getIt()));
  getIt.registerLazySingleton(() => RemoveTodoUseCase(getIt()));
  getIt.registerLazySingleton(() => GetTodosUseCase(getIt()));

  // Register BLoC
  getIt.registerFactory(() => TodoBloc(
        getTodos: getIt(),
        addTodo: getIt(),
        editTodo: getIt(),
        removeTodo: getIt(),
      ));
}
