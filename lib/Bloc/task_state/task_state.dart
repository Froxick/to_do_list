import 'package:to_do_list/entity/task.dart';

class TaskState {
  List<Task> taskList;
  int countCompleted;
  TaskState({required this.taskList, required this.countCompleted});
}
