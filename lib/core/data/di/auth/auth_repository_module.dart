import 'package:base_flutter_bloc/core/domain/repository/auth/auth_repository.dart';

import '../../../utils/di/injector.dart';
import '../../repository/auth/auth_repository_impl.dart';

Future<void> initializeAuthRepositoryDependencies() async {
  /// AuthRepository
  injector.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      injector(),
      injector(),
    ),
  );
}
