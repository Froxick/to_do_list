import 'package:get_it/get_it.dart';

import 'package:hive_flutter/adapters.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_list/entity/task.dart';
import 'locator.config.dart';

final sl = GetIt.instance;

@module
abstract class AppModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @preResolve
  Future<Box<Task>> get taskBox async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());
    return await Hive.openBox<Task>('tasks');
  }
}

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies() async => $initGetIt(sl);
