import 'package:base_flutter_bloc/core/domain/usecase/auth/get_list_user_use_case.dart';
import 'package:base_flutter_bloc/core/domain/usecase/auth/set_access_token_use_case.dart';
import 'package:base_flutter_bloc/core/utils/common/helper.dart';
import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/model/data/remote/response/auth/user_model.dart';

part 'home_event.dart';

part 'home_state.dart';

part 'home_bloc.freezed.dart';

const throttleDuration = Duration(milliseconds: 500);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttleTime(duration), mapper);
  };
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetListUserUseCase getListUserUseCase;
  final SetAccessTokenUseCase setAccessTokenUseCase;

  HomeBloc({
    required this.getListUserUseCase,
    required this.setAccessTokenUseCase,
  }) : super(HomeState.initial()) {
    on<_Logout>(_logout);
    on<_FetchUser>(
      _onFetchUser,
      transformer: throttleDroppable(throttleDuration),
      // transformer: (events, mapper) {
      //   return events
      //       .debounceTime(const Duration(milliseconds: 500))
      //       .flatMap(mapper);
      // },
    );
  }

  Future<void> _onFetchUser(
    HomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    await event.whenOrNull(
      fetchUser: (search, page, isNewSearch) async {
        if (state.hasReachedMax || state.isLoading && !isNewSearch) return;

        final List<UserModel> updatedUserData = isNewSearch ? [] : state.userData;

        emit(state.copyWith(
          isLoading: true,
          page: page,
          userData: updatedUserData,
          hasReachedMax: false,
        ));

        final result = await getListUserUseCase(
          page: page.toString(),
          limit: "10",
          search: search,
        );

        result.when(
          success: (data) {
            if (data.data?.isEmpty == true) {
              emit(state.copyWith(
                isLoading: false,
                hasReachedMax: true,
              ));
            } else {
              emit(state.copyWith(
                // userData: data.data,
                userData: [
                  ...updatedUserData,
                  ...?data.data,
                ],
                page: page + 1,
                isLoading: false,
                hasReachedMax: false,
              ));
            }
          },
          failed: (e) {
            emit(state.copyWith(isLoading: false, userError: e));
          },
        );
      },
    );
  }

  Future<void> _logout(HomeEvent event, Emitter<HomeState> emit) async {
    await setAccessTokenUseCase("");
  }
}
