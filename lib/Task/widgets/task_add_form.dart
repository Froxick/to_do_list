import 'package:flutter/material.dart';
import 'package:to_do_list/Task/widgets/prioritySelector.dart';
import 'package:to_do_list/entity/task.dart';

class TaskAddForm extends StatefulWidget {
  final Function(Task) onTaskAdd;

  TaskAddForm({super.key, required this.onTaskAdd});

  @override
  _TaskAddFormState createState() => _TaskAddFormState();
}

class _TaskAddFormState extends State<TaskAddForm> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  String _priority = 'green';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              decoration: InputDecoration(labelText: 'Заголовок'),
              onSaved: (value) {
                _title = value!;
              },
            ),
            SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(labelText: 'Описание'),
              onSaved: (value) {
                _description = value!;
              },
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 40),
                  child: Text(
                    'Приоретет',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: const Color.fromARGB(255, 168, 168, 168),
                              width: 1,
                              style: BorderStyle.solid))),
                  child: PrioritySelector(
                      selctedPriority: _priority,
                      onPriorityChanged: (newPriority) {
                        setState(() {
                          _priority = newPriority;
                        });
                      }),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            ElevatedButton(
                onPressed: () {
                  _formKey.currentState?.save();
                  Task newTask = Task(
                      title: _title,
                      description: _description,
                      date: '',
                      priority: _priority);

                  widget.onTaskAdd(newTask);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 194, 255, 145)),
                child: Text(
                  'Добавить',
                  style: TextStyle(color: Colors.black),
                ))
          ],
        ),
      ),
    );
  }
}
