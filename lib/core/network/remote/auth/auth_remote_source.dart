import 'package:base_flutter_bloc/core/model/data/remote/request/auth/refresh_token_request.dart';
import 'package:base_flutter_bloc/core/model/data/remote/response/auth/token_model.dart';
import 'package:base_flutter_bloc/core/model/data/remote/response/auth/user_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../model/data/remote/request/auth/auth_request.dart';

part 'auth_remote_source.g.dart';

@RestApi()
abstract class AuthRemoteSource {
  factory AuthRemoteSource(Dio dio, {String baseUrl}) = _AuthRemoteSource;

  @POST('auth/login')
  Future<UserModel> login(
    @Body() LoginRequest request,
  );

  @GET('auth/me')
  Future<UserModel> getUser();

  @POST('auth/refresh')
  Future<TokenModel> refreshToken(
    @Body() RefreshTokenRequest request,
  );
}
