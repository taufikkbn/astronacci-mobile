import 'package:base_flutter_bloc/core/data/utils/execute_response.dart';
import 'package:base_flutter_bloc/core/model/data/remote/request/auth/auth_request.dart';
import 'package:base_flutter_bloc/core/model/data/remote/request/auth/refresh_token_request.dart';
import 'package:base_flutter_bloc/core/model/data/remote/response/auth/token_model.dart';
import 'package:base_flutter_bloc/core/model/data/remote/response/auth/user_model.dart';
import 'package:base_flutter_bloc/core/network/remote/auth/auth_remote_source.dart';
import 'package:base_flutter_bloc/core/utils/common/helper.dart';

import '../../../domain/repository/auth/auth_repository.dart';
import '../../../local/datastore/local_storage.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteSource authRemoteSource;
  final LocalStorage localStorage;

  AuthRepositoryImpl(this.authRemoteSource, this.localStorage);

  @override
  DataResult<UserModel> getUser() async {
    return executeResponse(
      networkCall: () => authRemoteSource.getUser(),
      action: (response) => response,
    );
  }

  @override
  DataResult<UserModel> login(LoginRequest request) async {
    return executeResponse(
      networkCall: () => authRemoteSource.login(request),
      action: (response) {
        localStorage.setString(LocalStorage.tokenKey, response.token!);
        localStorage.setString(LocalStorage.refreshTokenKey, response.refreshToken!);
        return response;
      },
    );
  }

  @override
  DataResult<TokenModel> refreshToken(RefreshTokenRequest request) async {
    return executeResponse(
      networkCall: () => authRemoteSource.refreshToken(request),
      action: (response) => response,
    );
  }
}
