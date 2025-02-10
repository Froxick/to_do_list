import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_list/Bloc/task_bloc/task_bloc.dart';
import 'package:to_do_list/Bloc/task_event/task_event.dart';
import 'package:to_do_list/Task/widgets/prioritySelector.dart';
import 'package:to_do_list/entity/task.dart';

class TaskViewForm extends StatefulWidget {
  // final Function(Task) onTaskAdd;
  //final ValueChanged<Task> changeFnc;
  final int indexTask;
  final TaskBloc taskBloc;
  final Task task;
  TaskViewForm(
      {super.key,
      required this.task,
      required this.taskBloc,
      required this.indexTask});

  @override
  _TaskViewFormState createState() => _TaskViewFormState();
}

class _TaskViewFormState extends State<TaskViewForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  bool checkBool = false;
  String _priority = 'green';

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController =
        TextEditingController(text: widget.task.description);
    _priority = widget.task.priority;
    _titleController.addListener(_check);
    _descriptionController.addListener(_check);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _titleController.removeListener(_check);
    _descriptionController.removeListener(_check);
    super.dispose();
  }

  @override
  void _check() {
    bool hasChanges = _titleController.text != widget.task.title ||
        _descriptionController.text != widget.task.description ||
        _priority != widget.task.priority;

    if (mounted) {
      setState(() {
        checkBool = hasChanges;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                    labelText: 'Заголовок',
                    labelStyle: TextStyle(fontSize: 20),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                    labelText: 'Описание',
                    labelStyle: TextStyle(fontSize: 18),
                    filled: true,
                    fillColor: const Color.fromARGB(255, 255, 255, 255),
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none),
                style: TextStyle(fontSize: 18),
                maxLines: 8,
                keyboardType: TextInputType.multiline,
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 45),
                    child: Text(
                      'Приоритет',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 80),
                    decoration: BoxDecoration(),
                    child: PrioritySelector(
                        selctedPriority: _priority,
                        onPriorityChanged: (newPriority) {
                          setState(() {
                            _priority = newPriority;
                          });
                          _check();
                        }),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (checkBool) {
                      _formKey.currentState?.save();
                      Task newTask = Task(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          date: '',
                          priority: _priority);
                      widget.taskBloc.add(ChangeTaskEvent(
                          newTask: newTask,
                          viewTaskIndex: widget.indexTask,
                          oldTask: widget.task));
                      Navigator.pop(context);
                    }

//widget.onTaskAdd(newTask);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: checkBool
                          ? const Color.fromARGB(255, 194, 255, 145)
                          : const Color.fromARGB(144, 65, 116, 22)),
                  child: Text(
                    'Сохранить',
                    style: TextStyle(color: Colors.black),
                  )),
              SizedBox(
                height: 180,
              )
            ],
          ),
        ),
      ),
    );
  }
}
