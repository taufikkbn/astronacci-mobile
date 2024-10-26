import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../app/go_routes.dart';

class SampleScreen extends StatefulWidget {
  const SampleScreen({super.key});

  static Widget screen(BuildContext context, GoRouterState state) {
    return const SampleScreen();
  }

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      context.goNamed(Routes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sample Screen"),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sample Screen',
            ),
          ],
        ),
      ),
    );
  }
}
