import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_list/Bloc/task_bloc/task_bloc.dart';
import 'package:to_do_list/Bloc/task_event/task_event.dart';

class StaticsScreen extends StatefulWidget {
  StaticsScreen({super.key});

  @override
  State<StaticsScreen> createState() => _StaticsScreenState();
}

class _StaticsScreenState extends State<StaticsScreen> {
  @override
  Widget build(BuildContext context) {
    final taskBloc = BlocProvider.of<TaskBloc>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
          title: Container(
        margin: EdgeInsets.only(top: 25, left: 10),
        child: Text(
          'Статистика',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
        ),
      )),
      body: Center(
          child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 40, bottom: 20),
            child: Image.asset(
              'assets/image/stat.svg',
              width: 300,
            ),
          ),
          Container(
              child: Column(
            children: [
              Text(
                'Количество выполненных задач:',
                style: TextStyle(fontSize: 22),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Text(
                  '${taskBloc.state.countCompleted}',
                  style: TextStyle(
                      color: const Color.fromARGB(255, 35, 124, 6),
                      fontWeight: FontWeight.w500,
                      fontSize: 45),
                ),
              )
            ],
          )),
          Container(
            margin: EdgeInsets.only(top: 40),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: Size(200, 45),
                    backgroundColor: const Color.fromARGB(255, 194, 255, 145)),
                onPressed: () {
                  taskBloc.add(ClearCounterEvent());
                },
                child: Text(
                  'Очистить',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                )),
          )
        ],
      )),
    );
  }
}
