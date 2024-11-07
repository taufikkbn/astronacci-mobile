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
  }) : super(LoginState.initial()) {
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
    emit(LoginState.loading());
    final result = await loginUseCase(username, password);
    result.when(
      success: (data) {
        emit(LoginState.success(data));
      },
      failed: (e) {
        emit(LoginState.failed(e));
      },
    );
  }

}
