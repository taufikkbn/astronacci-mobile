import 'package:base_flutter_bloc/presentation/screens/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:synchronized/extension.dart';

import '../../../../core/utils/di/injector.dart';
import '../../../app/go_routes.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  static Widget screen(BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => injector<LoginBloc>()),
      ],
      child: LoginScreen(),
    );
  }

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController()..text = 'emilys';

  final _passwordController = TextEditingController()..text = 'emilyspass';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
              return state.when(
                initial: () => const SizedBox(),
                userDataLoading: () => const CircularProgressIndicator(),
                userDataSuccess: (data) => Text(data.username!),
                userDataFailed: (error) => Text(error.message),
              );
            }),
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                state.whenOrNull(userDataSuccess: (data) {
                  context.pushNamed(Routes.home);
                  // context.goNamed(Routes.home);
                });
              },
              child: ElevatedButton(
                onPressed: () {
                  final username = _usernameController.text;
                  final password = _passwordController.text;

                  context
                      .read<LoginBloc>()
                      .add(LoginEvent.login(username, password));
                },
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    injector<LoginBloc>().close();

    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
