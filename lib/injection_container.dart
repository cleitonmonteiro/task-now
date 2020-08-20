import 'package:get_it/get_it.dart';
import 'package:task_now/app_theme_notifier.dart';
import 'package:task_now/data/database_sqlite.dart';
import 'package:task_now/data/todo_repository.dart';
import 'package:task_now/todo_state_notifier.dart';

import 'data/todo_repository_sqlite_impl.dart';

final sl = GetIt.instance;

Future<void> setup() async {
  sl.registerLazySingleton<DatabaseProviderSqlite>(
      () => DatabaseProviderSqlite());

  sl.registerLazySingleton<TodoRepository>(
      () => TodoRepositorySqliteImpl(sl.get()));

  sl.registerLazySingleton<AppThemeNotifier>(() => AppThemeNotifier());

  sl.registerLazySingleton<TodoStateNotifier>(
      () => TodoStateNotifier(sl.get()));
}
