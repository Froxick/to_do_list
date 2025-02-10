import 'package:to_do_list/entity/task.dart';

abstract class TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final Task task;
  AddTaskEvent({required this.task});
}

class DeleteTaskEvent extends TaskEvent {
  final Task task;

  DeleteTaskEvent({required this.task});
}

class CompleteTaskEvent extends TaskEvent {
  final Task task;

  CompleteTaskEvent({
    required this.task,
  });
}

class PlusEvenet extends TaskEvent {} //test

class ClearCounterEvent extends TaskEvent {} // clear test

class ChangeTaskEvent extends TaskEvent {
  final Task newTask;
  final Task oldTask;
  final int viewTaskIndex;
  ChangeTaskEvent(
      {required this.newTask,
      required this.viewTaskIndex,
      required this.oldTask});
}
