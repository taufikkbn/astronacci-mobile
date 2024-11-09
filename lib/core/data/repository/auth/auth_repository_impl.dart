import 'package:base_flutter_bloc/core/data/utils/execute_response.dart';
import 'package:base_flutter_bloc/core/model/data/remote/request/auth/auth_request.dart';
import 'package:base_flutter_bloc/core/model/data/remote/request/auth/register_request.dart';
import 'package:base_flutter_bloc/core/model/data/remote/request/auth/user_update_request.dart';
import 'package:base_flutter_bloc/core/model/data/remote/response/auth/user_model.dart';
import 'package:base_flutter_bloc/core/model/data/remote/response/base_paging_response.dart';
import 'package:base_flutter_bloc/core/network/remote/auth/auth_remote_source.dart';
import 'package:base_flutter_bloc/core/utils/common/helper.dart';
import 'package:dio/dio.dart';
import 'package:dio/src/form_data.dart';

import '../../../domain/repository/auth/auth_repository.dart';
import '../../../local/datastore/local_storage.dart';
import '../../../model/data/remote/response/auth/forgot_password_model.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteSource authRemoteSource;
  final LocalStorage localStorage;

  AuthRepositoryImpl(this.authRemoteSource, this.localStorage);

  @override
  DataResult<UserModel> getUser(String id) async {
    return executeResponse(
      networkCall: () => authRemoteSource.getUser(id),
      action: (response) => response,
    );
  }

  @override
  DataResult<UserModel> login(LoginRequest request) async {
    return executeResponse(
      networkCall: () => authRemoteSource.login(request),
      action: (response) {
        localStorage.setString(LocalStorage.tokenKey, response.token!);
        // localStorage.setString(LocalStorage.refreshTokenKey, response.refreshToken!);
        return response;
      },
    );
  }

  @override
  DataResult<ForgotPasswordModel> forgotPassword(String email) async {
    return executeResponse(
      networkCall: () => authRemoteSource.forgotPassword(email),
      action: (response) => response,
    );
  }

  @override
  DataResult<BasePagingResponse<UserModel>> getListUser(
      String page, String limit, String? search) {
    return executeResponse(
      networkCall: () => authRemoteSource.getListUser(page, limit, search),
      action: (response) => response,
    );
  }

  @override
  DataResult<UserModel> register(RegisterRequest request) {
    return executeResponse(
      networkCall: () => authRemoteSource.register(request),
      action: (response) => response,
    );
  }

  @override
  DataResult updateUser(
    UserUpdateRequest request,
  ) {
    return executeResponse(
      networkCall: () async {
        MultipartFile? file;

        if (request.imagePath != null) {
          file = await MultipartFile.fromFile(request.imagePath!);
        }

        final formData = FormData.fromMap({
          "name": request.name,
          "email": request.email,
          "password": request.password,
          "confirmPassword": request.confirmPassword,
          "image": file,
        });

        return authRemoteSource.updateUser(request.id!, formData);
      },
      action: (response) => response,
    );
  }
}
