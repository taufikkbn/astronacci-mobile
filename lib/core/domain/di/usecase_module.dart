import 'auth/auth_use_case_module.dart';

Future<void> initializeUseCaseDependencies() async {
  await initializeAuthUseCaseDependencies();
}
