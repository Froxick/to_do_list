// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:hive_flutter/adapters.dart' as _i744;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../Bloc/task_bloc/task_bloc.dart' as _i24;
import '../entity/task.dart' as _i878;
import 'locator.dart' as _i775;

// initializes the registration of main-scope dependencies inside of GetIt
Future<_i174.GetIt> $initGetIt(
  _i174.GetIt getIt, {
  String? environment,
  _i526.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i526.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final appModule = _$AppModule();
  await gh.factoryAsync<_i460.SharedPreferences>(
    () => appModule.prefs,
    preResolve: true,
  );
  await gh.factoryAsync<_i744.Box<_i878.Task>>(
    () => appModule.taskBox,
    preResolve: true,
  );
  gh.factory<_i24.TaskBloc>(() => _i24.TaskBloc(
        gh<_i979.Box<_i878.Task>>(),
        gh<_i460.SharedPreferences>(),
      ));
  return getIt;
}

class _$AppModule extends _i775.AppModule {}
