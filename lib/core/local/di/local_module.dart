import 'package:base_flutter_bloc/core/local/datastore/local_storage.dart';
import 'package:base_flutter_bloc/core/local/datastore/local_storage_impl.dart';

import '../../utils/di/injector.dart';

Future<void> initializeLocalDependencies() async {

  /// LocalStorage
  injector.registerLazySingleton<LocalStorage>(
    () => LocalStorageImpl(),
  );
}
