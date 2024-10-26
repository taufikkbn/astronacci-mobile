import 'package:base_flutter_bloc/presentation/screens/sample/counter_cubit.dart';

import '../../core/utils/di/injector.dart';

Future<void> initializeCubitDependencies() async {

  injector.registerFactory<CounterCubit>(
    () => CounterCubit(),
  );

}
