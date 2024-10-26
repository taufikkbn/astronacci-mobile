import 'package:base_flutter_bloc/presentation/utils/notifications/chucker_notification_.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'app.dart';
import 'core/data/di/repository_module.dart';
import 'core/domain/di/usecase_module.dart';
import 'core/local/di/local_module.dart';
import 'core/network/di/remote_module.dart';
import 'core/utils/bloc/bloc_observer.dart';
import 'presentation/di/bloc_module.dart';
import 'presentation/di/cubit_module.dart';

void main() async {
  await initialize();
  runApp( const App());
}

Future initialize() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = AppBlocObserver();

  await ChuckerNotification.showNotification();

  await Hive.initFlutter();

  await dependencies();
}

Future dependencies() async {
  await initializeLocalDependencies();
  await initializeRemoteDependencies();
  await initializeRepositoryDependencies();
  await initializeUseCaseDependencies();
  await initializeBlocDependencies();
  await initializeCubitDependencies();
}