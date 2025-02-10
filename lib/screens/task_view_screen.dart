import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/Bloc/task_bloc/task_bloc.dart';
import 'package:to_do_list/Task/widgets/task_view_form.dart';
import 'package:to_do_list/entity/task.dart';

class TaskViewScreen extends StatefulWidget {
  final int taskIndex;
  final Task task;
  final TaskBloc taskBloc;
  const TaskViewScreen(
      {super.key,
      required this.taskIndex,
      required this.task,
      required this.taskBloc});

  @override
  State<TaskViewScreen> createState() => _TaskViewScreenState();
}

class _TaskViewScreenState extends State<TaskViewScreen> {
  @override
  Widget build(BuildContext context) {
    //final taskBloc = BlocProvider.of<TaskBloc>(context, listen: true);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 237, 237),
      appBar: AppBar(
        title: Text('Редактирование'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 194, 255, 145),
      ),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(bottom: 0),
          child: TaskViewForm(
            indexTask: widget.taskIndex,
            task: widget.task,
            taskBloc: widget.taskBloc,
          ),
        ),
      ),
    );
  }
}
