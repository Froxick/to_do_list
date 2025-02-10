import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:to_do_list/Bloc/task_bloc/task_bloc.dart';
import 'package:to_do_list/entity/task.dart';

import 'package:to_do_list/screens/home_screen.dart';
import 'package:to_do_list/screens/main_screen.dart';
import 'locator/locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  // await sl.configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<TaskBloc>(
        create: (context) => sl<TaskBloc>(),
        child: MainScreen(),
      ),
    );
  }
}
