import 'package:flutter/material.dart';
import 'package:to_do_list/Bloc/task_bloc/task_bloc.dart';
import 'package:to_do_list/Bloc/task_event/task_event.dart';
import 'package:to_do_list/Task/widgets/task_view_form.dart';
import 'package:to_do_list/entity/task.dart';
import 'package:to_do_list/screens/task_view_screen.dart';

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  final TaskBloc taskBloc;
  final String filter;
  TaskList({required this.tasks, required this.taskBloc, required this.filter});
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView.builder(
      itemCount: filter == 'all'
          ? tasks.length
          : tasks.where((task) => task.priority == filter).length,
      itemBuilder: (context, index) {
        final task = filter == 'all'
            ? tasks[index]
            : tasks.where((task) => task.priority == filter).toList()[index];
        Color color;
        if (task.priority == 'red') {
          color = const Color.fromARGB(255, 255, 200, 197);
        } else if (task.priority == 'yellow') {
          color = const Color.fromARGB(255, 255, 251, 217);
        } else if (task.priority == 'green') {
          color = const Color.fromARGB(255, 228, 252, 228);
        } else {
          color = Colors.white;
        }

        return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TaskViewScreen(
                            taskIndex: index,
                            taskBloc: taskBloc,
                            task: task,
                          )));
            },
            child: Card(
                color: color,
                margin: EdgeInsets.all(8.0),
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            taskBloc.add(CompleteTaskEvent(task: task));
                          },
                          child: Container(
                            width: 35,
                            height: 35,
                            margin: EdgeInsets.only(right: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                    style: BorderStyle.solid),
                                color: const Color.fromARGB(0, 255, 255, 255)),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                task.title,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 1.0),
                              Text(task.description),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            print('удалить');
                            //onDelete(index);
                            taskBloc.add(DeleteTaskEvent(task: task));
                          },
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                        ),
                      ],
                    ))));
      },
    ));
  }
}
