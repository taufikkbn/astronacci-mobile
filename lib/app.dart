import 'package:base_flutter_bloc/core/utils/extensions/extensions_media_query.dart';
import 'package:base_flutter_bloc/presentation/app/go_routes.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Base Flutter Bloc',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false
      ),
      builder: (context, child) {
        return MediaQuery(
          data: context.mediaQuery.copyWith(
            textScaler: const TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
    );
  }
}
