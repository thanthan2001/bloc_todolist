import 'package:objectbox/objectbox.dart';

@Entity()
class TodoModel {
  int id;
  String title;
  String description;
  bool isCompleted;

  TodoModel({
    this.id = 0,
    required this.title,
    required this.description,
    this.isCompleted = false,
  });
}
