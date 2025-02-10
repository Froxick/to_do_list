import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/Bloc/task_bloc/task_bloc.dart';
import 'package:to_do_list/Bloc/task_event/task_event.dart';
import 'package:to_do_list/Task/widgets/button_filter.dart';
import 'package:to_do_list/Task/widgets/task_add_form.dart';
import 'package:to_do_list/Task/widgets/task_list.dart';
import 'package:to_do_list/entity/task.dart';

class HomeScrean extends StatefulWidget {
  const HomeScrean({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScrean> createState() => _HomeScreanState();
}

class _HomeScreanState extends State<HomeScrean> {
  String filter = 'all';
  void _updateFilter(String newFilter) {
    setState(() {
      filter = newFilter;
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskBlock = BlocProvider.of<TaskBloc>(context, listen: true);
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 234, 234, 234),
        appBar: AppBar(
          toolbarHeight: 60,
          actions: [
            Flexible(
              // or Expanded
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      mainAxisSize: MainAxisSize.min, // Add this line!
                      children: [
                        ButtonFilter(
                            buttonText: 'Все',
                            filter: filter,
                            filterSetValue: 'all',
                            onChangeFilter: _updateFilter),
                        SizedBox(width: 5),
                        ButtonFilter(
                            buttonText: 'Высокий приоритет',
                            filter: filter,
                            filterSetValue: 'red',
                            onChangeFilter: _updateFilter),
                        SizedBox(width: 5),
                        ButtonFilter(
                            buttonText: 'Средний приоритет',
                            filter: filter,
                            filterSetValue: 'yellow',
                            onChangeFilter: _updateFilter),
                        SizedBox(width: 5),
                        ButtonFilter(
                            buttonText: 'Низкий приоритет',
                            filter: filter,
                            filterSetValue: 'green',
                            onChangeFilter: _updateFilter),
                        SizedBox(width: 5),
                      ],
                    ),
                  )),
            ),
          ],
          backgroundColor: const Color.fromARGB(255, 194, 255, 145),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: (filter == 'all'
                        ? taskBlock.state.taskList.isNotEmpty
                        : taskBlock.state.taskList
                            .where((task) => task.priority == filter)
                            .isNotEmpty)
                    ? TaskList(
                        filter: filter,
                        taskBloc: taskBlock,
                        tasks: taskBlock.state.taskList,
                      )
                    : Container(
                        margin: EdgeInsets.only(top: 50),
                        child: Text(
                          '               У вас пока нет задач. \n Добавьте их используя кнопку снизу',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
              ),
            ],
          ),
        ),
        floatingActionButton: SizedBox(
          width: 65,
          height: 65,
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                        title: Text('Задача'),
                        content: Container(
                          height: MediaQuery.of(context).size.height / 2.8,
                          width: MediaQuery.of(context).size.width * 0.8,
                          constraints: BoxConstraints(
                            maxHeight: 400,
                          ),
                          child: SingleChildScrollView(
                            child: TaskAddForm(onTaskAdd: (task) {
                              taskBlock.add(AddTaskEvent(task: task));
                              Navigator.of(context).pop();
                            }),
                          ),
                        ));
                  });
            },
            child: Icon(Icons.add),
            backgroundColor: const Color.fromARGB(255, 194, 255, 145),
            elevation: 5,
            tooltip: 'Add New Item',
            shape: RoundedRectangleBorder(
              // Add rounded corners
              borderRadius: BorderRadius.circular(45),
            ),
          ),
        ));
  }
}
