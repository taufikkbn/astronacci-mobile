import 'package:base_flutter_bloc/core/domain/usecase/auth/register_use_case.dart';
import 'package:base_flutter_bloc/core/model/data/remote/request/auth/register_request.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/model/data/remote/response/auth/user_model.dart';
import '../../../../core/utils/common/helper.dart';

part 'register_event.dart';

part 'register_state.dart';

part 'register_bloc.freezed.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;

  RegisterBloc({required this.registerUseCase})
      : super(RegisterState.initial()) {
    on<RegisterEvent>(_onEvent);
  }

  Future<void> _onEvent(
    RegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    await event.when(
      started: () {},
      registerSubmit: (request) => _onRegisterSubmit(
        event,
        emit,
        request,
      ),
    );
  }

  Future<void> _onRegisterSubmit(
    RegisterEvent event,
    Emitter<RegisterState> emit,
    RegisterRequest request,
  ) async {
    emit(RegisterState.userDataLoading());
    final result = await registerUseCase(request);
    result.when(
      success: (data) {
        emit(RegisterState.userDataSuccess(data));
      },
      failed: (e) {
        emit(RegisterState.userDataFailed(e));
      },
    );
  }
}
