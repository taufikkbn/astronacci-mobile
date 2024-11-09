import 'package:base_flutter_bloc/core/domain/usecase/auth/forgot_password_use_case.dart';
import 'package:base_flutter_bloc/core/model/data/remote/response/auth/forgot_password_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/utils/common/helper.dart';

part 'forgot_event.dart';

part 'forgot_state.dart';

part 'forgot_bloc.freezed.dart';

class ForgotBloc extends Bloc<ForgotEvent, ForgotState> {
  final ForgotPasswordUseCase forgotPasswordUseCase;

  ForgotBloc({required this.forgotPasswordUseCase})
      : super(ForgotState.initial()) {
    on<ForgotEvent>(_onEvent);
  }

  Future<void> _onEvent(ForgotEvent event, Emitter<ForgotState> emit) async {
    await event.when(
      started: () {},
      sendEmail: (email) => _sendEmail(event, emit, email),
    );
  }

  Future<void> _sendEmail(
    ForgotEvent event,
    Emitter<ForgotState> emit,
    String email,
  ) async {
    emit(ForgotState.userDataLoading());
    final result = await forgotPasswordUseCase(email);
    result.when(
      success: (data) {
        emit(ForgotState.userDataSuccess(data));
      },
      failed: (e) {
        emit(ForgotState.userDataFailed(e));
      },
    );
  }
}
