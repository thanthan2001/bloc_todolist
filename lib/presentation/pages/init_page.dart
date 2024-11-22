import 'package:auto_route/auto_route.dart';
import 'package:bloc_todo_test_v2/domain/entities/todo.dart';
import 'package:bloc_todo_test_v2/presentation/pages/todo_page.dart';
import 'package:bloc_todo_test_v2/routers/routers.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

@RoutePage()
class InitPage extends StatelessWidget {
  const InitPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Init Page"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.router.navigateNamed('/todo'); // Điều hướng đến "/todo"
          },
          child: const Text("Go to Todo Page"),
        ),
      ),
    );
  }
}
