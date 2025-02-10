import 'package:bloc/bloc.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/Bloc/task_event/task_event.dart';
import 'package:to_do_list/Bloc/task_state/task_state.dart';
import 'package:to_do_list/entity/task.dart';

@injectable
class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final Box<Task> _taskBox;
  final SharedPreferences _prefs;

  TaskBloc(this._taskBox, this._prefs)
      : super(TaskState(taskList: [], countCompleted: 0)) {
    on<AddTaskEvent>(_onAddTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<CompleteTaskEvent>(_onCompleteTask);
    on<PlusEvenet>(_plus);
    on<ClearCounterEvent>(_clearCounter);
    on<ChangeTaskEvent>(_changeTask);

    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final count = _prefs.getInt('completeTaskCount') ?? 0;
    emit(TaskState(taskList: _taskBox.values.toList(), countCompleted: count));
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    await _taskBox.add(event.task);
    emit(TaskState(
        taskList: _taskBox.values.toList(),
        countCompleted: state.countCompleted));
  }

  Future<void> _onDeleteTask(
      DeleteTaskEvent event, Emitter<TaskState> emit) async {
    final taskToDelete = event.task;
    int? indexToDelete;

    for (int i = 0; i < _taskBox.length; i++) {
      if (_taskBox.getAt(i) == taskToDelete) {
        indexToDelete = i;
        break;
      }
    }

    if (indexToDelete != null) {
      await _taskBox.deleteAt(indexToDelete);
      emit(TaskState(
          taskList: _taskBox.values.toList(),
          countCompleted: state.countCompleted));
    } else {
      print("Задача не найдена");
    }
  }

  Future<void> _onCompleteTask(
      CompleteTaskEvent event, Emitter<TaskState> emit) async {
    final taskToComplete = event.task;
    int? indexToComplete;

    for (int i = 0; i < _taskBox.length; i++) {
      if (_taskBox.getAt(i) == taskToComplete) {
        indexToComplete = i;
        break;
      }
    }

    if (indexToComplete != null) {
      await _taskBox.deleteAt(indexToComplete);
      final newCount = state.countCompleted + 1;
      await _prefs.setInt('completeTaskCount', newCount);
      emit(TaskState(
          taskList: _taskBox.values.toList(), countCompleted: newCount));
    } else {
      print("Задача не найдена");
    }
  }

  Future<void> _plus(PlusEvenet event, Emitter<TaskState> emit) async {
    final newCount = state.countCompleted + 1;
    await _prefs.setInt('completeTaskCount', newCount);
    emit(TaskState(
        taskList: _taskBox.values.toList(), countCompleted: newCount));
  }

  Future<void> _clearCounter(
      ClearCounterEvent event, Emitter<TaskState> emit) async {
    await _prefs.setInt('completeTaskCount', 0);
    emit(TaskState(taskList: _taskBox.values.toList(), countCompleted: 0));
  }

  Future<void> _changeTask(
      ChangeTaskEvent event, Emitter<TaskState> emit) async {
    final taskToChange = event.oldTask;
    final newTask = event.newTask;
    int? indexToChange;

    for (int i = 0; i < _taskBox.length; i++) {
      if (_taskBox.getAt(i) == taskToChange) {
        indexToChange = i;
        break;
      }
    }

    if (indexToChange != null) {
      try {
        final key = _taskBox.keyAt(indexToChange);
        await _taskBox.put(key, newTask);
        emit(TaskState(
            taskList: _taskBox.values.toList(),
            countCompleted: state.countCompleted));
      } catch (e) {
        print('ошибка при изменении $e');
      }
    } else {
      print("Задача не найдена в  _taskBox");
    }
  }
}
