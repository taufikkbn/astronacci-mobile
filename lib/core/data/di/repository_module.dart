import 'auth/auth_repository_module.dart';

Future<void> initializeRepositoryDependencies() async {
  await initializeAuthRepositoryDependencies();
}
