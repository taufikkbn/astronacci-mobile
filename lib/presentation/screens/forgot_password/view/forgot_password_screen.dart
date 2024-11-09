import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/di/injector.dart';
import '../bloc/forgot_bloc.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  static Widget screen(BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => injector<ForgotBloc>()),
      ],
      child: ForgotPasswordScreen(),
    );
  }

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            BlocBuilder<ForgotBloc, ForgotState>(builder: (context, state) {
              if (state.isLoading) return const CircularProgressIndicator();
              if (state.data != null) return Text(state.data?.message ?? '');
              if (state.userError != null) return Text(state.userError!.message);
              return const SizedBox();
            }),
            BlocListener<ForgotBloc, ForgotState>(
              listener: (context, state) {
                // if (state.userData != null) {
                //   context.pushNamed(Routes.home);
                // }
              },
              child: ElevatedButton(
                onPressed: () {
                  final email = _emailController.text;

                  context
                      .read<ForgotBloc>()
                      .add(ForgotEvent.sendEmail(email));
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
