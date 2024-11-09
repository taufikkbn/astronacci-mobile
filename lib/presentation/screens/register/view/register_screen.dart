import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/model/data/remote/request/auth/register_request.dart';
import '../../../../core/utils/di/injector.dart';
import '../bloc/register_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  static Widget screen(BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => injector<RegisterBloc>()),
      ],
      child: RegisterScreen(),
    );
  }

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordConfirmController,
                decoration: const InputDecoration(labelText: 'Confirm Password'),
              ),
              const SizedBox(height: 16),
              BlocBuilder<RegisterBloc, RegisterState>(builder: (context, state) {
                if (state.isLoading) return const CircularProgressIndicator();
                if (state.userData != null) return Text('Successfully Register');
                if (state.userError != null) return Text(state.userError!.message);
                return const SizedBox();
              }),
              BlocListener<RegisterBloc, RegisterState>(
                listener: (context, state) {
                  // if (state.userData != null) {
                  //   context.pushNamed(Routes.home);
                  // }
                },
                child: ElevatedButton(
                  onPressed: () {
                    final email = _emailController.text;
                    final username = _usernameController.text;
                    final password = _passwordController.text;
                    final passwordConfirm = _passwordConfirmController.text;
        
                    final request = RegisterRequest(
                      email: email,
                      name: username,
                      password: password,
                      confirmPassword: passwordConfirm,
                    );
        
                    context
                        .read<RegisterBloc>()
                        .add(RegisterEvent.registerSubmit(request));
                  },
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
