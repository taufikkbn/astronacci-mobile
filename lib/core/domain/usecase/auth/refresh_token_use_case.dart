import 'package:base_flutter_bloc/core/model/data/remote/request/auth/refresh_token_request.dart';
import 'package:base_flutter_bloc/core/model/data/remote/response/auth/token_model.dart';
import 'package:base_flutter_bloc/core/utils/common/helper.dart';

import '../../../local/datastore/local_storage.dart';
import '../../repository/auth/auth_repository.dart';

class RefreshTokenUseCase {
  final AuthRepository _authRepository;
  final LocalStorage _localStorage;

  RefreshTokenUseCase(
    this._authRepository,
    this._localStorage,
  );

  DataResult<TokenModel> call(int time) async {
    final refreshToken = await _localStorage.getString(LocalStorage.refreshTokenKey);

    final request = RefreshTokenRequest(
      refreshToken: refreshToken,
      expiresInMins: time.toString(),
    );

    return await _authRepository.refreshToken(request);
  }
}
