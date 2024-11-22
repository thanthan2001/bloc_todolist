import 'package:auto_route/auto_route.dart';
import 'package:bloc_todo_test_v2/presentation/pages/init_page.dart';
import 'package:bloc_todo_test_v2/presentation/pages/todo_page.dart';
import 'package:bloc_todo_test_v2/routers/routers.gr.dart';

// @AutoRouterConfig(replaceInRouteName: 'Page|Screen,Route')
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter() : super();
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: InitRoute.page, initial: true, path: '/'),
        AutoRoute(page: TodoRoute.page, path: '/todo'),
      ];
}

class $AppRouter {}
