import 'package:base_flutter_bloc/core/utils/common/helper.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/domain/usecase/auth/get_user_use_case.dart';
import '../../../../core/model/data/remote/response/auth/user_model.dart';

part 'home_event.dart';

part 'home_state.dart';

part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetUserUseCase getUserUseCase;

  HomeBloc({
    required this.getUserUseCase,
  }) : super(HomeState.initial()) {
    on<_Initial>(_initial);
  }

  Future<void> _initial(HomeEvent event, Emitter<HomeState> emit) async {
    emit(HomeState.userDataLoading());
    final result = await getUserUseCase();
    result.when(
      success: (data) {
        emit(HomeState.userDataSuccess(data));
      },
      failed: (e) {
        emit(HomeState.userDataFailed(e));
      },
    );
  }
}
