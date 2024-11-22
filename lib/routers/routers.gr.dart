// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:bloc_todo_test_v2/presentation/pages/init_page.dart' as _i1;
import 'package:bloc_todo_test_v2/presentation/pages/todo_page.dart' as _i2;

/// generated route for
/// [_i1.InitPage]
class InitRoute extends _i3.PageRouteInfo<void> {
  const InitRoute({List<_i3.PageRouteInfo>? children})
      : super(
          InitRoute.name,
          initialChildren: children,
        );

  static const String name = 'InitRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.InitPage();
    },
  );
}

/// generated route for
/// [_i2.TodoPage]
class TodoRoute extends _i3.PageRouteInfo<void> {
  const TodoRoute({List<_i3.PageRouteInfo>? children})
      : super(
          TodoRoute.name,
          initialChildren: children,
        );

  static const String name = 'TodoRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return _i2.TodoPage();
    },
  );
}
