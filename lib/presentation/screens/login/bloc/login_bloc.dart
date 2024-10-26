import 'dart:developer';

import 'package:base_flutter_bloc/core/utils/common/helper.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/usecase/auth/login_use_case.dart';
import '../../../../core/model/data/remote/response/auth/user_model.dart';

part 'login_event.dart';

part 'login_state.dart';

part 'login_bloc.freezed.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({
    required this.loginUseCase,
  }) : super(const LoginState.initial()) {
    on<LoginEvent>(_onLoginEvent);
  }

  void _onLoginEvent(LoginEvent event, Emitter<LoginState> emit) async {
    await event.when(
      login: (username, password) => _login(
        username,
        password,
        emit,
      ),
    );
  }

  Future<void> _login(
    String username,
    String password,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginState.userDataLoading());
    final result = await loginUseCase(username, password, 1);
    result.when(
      success: (data) {
        emit(LoginState.userDataSuccess(data));
      },
      failed: (e) {
        emit(LoginState.userDataFailed(e));
      },
    );
  }

  void _test() async {
    log("Start: ${DateTime.now()}");
    final result = await Future.wait([
      _task(1),
      _task(2),
      _task(3),
      _task(4),
    ]);
    log("End: ${DateTime.now()}");
    log("Result: $result");
  }

  Future<int> _task(int sec) async {
    await Future.delayed(Duration(seconds: sec));
    return sec;
  }
}
