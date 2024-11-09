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
    Future.delayed(const Duration(seconds: 1), () {
      context.goNamed(Routes.login);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.account_circle,
              size: 64,
              color: Colors.blueAccent,
            ),
            SizedBox(height: 16),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
