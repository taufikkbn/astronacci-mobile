import 'dart:developer';

import 'package:base_flutter_bloc/presentation/utils/extensions/media_query.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/utils/di/injector.dart';
import '../bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Widget screen(BuildContext context, GoRouterState state) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => injector<HomeBloc>()..add(const HomeEvent.initial()),
        ),
      ],
      child: const HomeScreen(),
    );
  }

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<HomeBloc>().add(const HomeEvent.initial());
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              Container(
                color: Colors.red,
                height: context.height * 0.9,
                width: double.infinity,
                child: Center(
                  child: BlocListener<HomeBloc, HomeState>(
                    listener: (context, state) {
                      log("HomeState cuaks listener: $state");
                    },
                    child: BlocBuilder<HomeBloc, HomeState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          userDataLoading: () => const CircularProgressIndicator(),
                          userDataSuccess: (data) => Text(data.username!),
                          userDataFailed: (error) => Text(error.message),
                          orElse: () => const SizedBox.shrink(),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    injector<HomeBloc>().close();
    super.dispose();
  }

}
