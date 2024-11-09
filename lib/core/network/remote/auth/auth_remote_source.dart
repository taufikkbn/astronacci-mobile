import 'dart:io';

import 'package:base_flutter_bloc/core/model/data/remote/request/auth/refresh_token_request.dart';
import 'package:base_flutter_bloc/core/model/data/remote/response/auth/token_model.dart';
import 'package:base_flutter_bloc/core/model/data/remote/response/auth/user_model.dart';
import 'package:base_flutter_bloc/core/model/data/remote/response/base_paging_response.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../../model/data/remote/request/auth/auth_request.dart';
import '../../../model/data/remote/request/auth/register_request.dart';
import '../../../model/data/remote/response/auth/forgot_password_model.dart';

part 'auth_remote_source.g.dart';

@RestApi()
abstract class AuthRemoteSource {
  factory AuthRemoteSource(Dio dio, {String baseUrl}) = _AuthRemoteSource;

  @POST('user/login')
  Future<UserModel> login(
    @Body() LoginRequest request,
  );

  @POST('user/register')
  Future<UserModel> register(
    @Body() RegisterRequest request,
  );

  @POST('user/forgot-password')
  Future<ForgotPasswordModel> forgotPassword(
    @Query('email') String email,
  );

  @GET('user')
  Future<BasePagingResponse<UserModel>> getListUser(
    @Query('page') String page,
    @Query('limit') String limit,
    @Query('search') String? search,
  );

  @GET('user/{id}')
  Future<UserModel> getUser(
    @Path('id') String id,
  );

  @PUT('user/{id}')
  Future<dynamic> updateUser(
    @Path('id') String id,
    @Body() FormData userModel,
  );
}
