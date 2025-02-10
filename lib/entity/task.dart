import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String title;
  @HiveField(1)
  String description;
  @HiveField(2)
  String date; // надо убрать но мне лень
  @HiveField(3)
  String priority;

  Task(
      {required this.title,
      required this.description,
      required this.date,
      required this.priority});
}
