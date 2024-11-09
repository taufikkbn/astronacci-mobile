import 'package:base_flutter_bloc/core/model/data/remote/request/auth/auth_request.dart';
import 'package:base_flutter_bloc/core/model/data/remote/response/auth/user_model.dart';

import '../../../model/data/remote/request/auth/register_request.dart';
import '../../../model/data/remote/request/auth/user_update_request.dart';
import '../../../model/data/remote/response/auth/forgot_password_model.dart';
import '../../../model/data/remote/response/base_paging_response.dart';
import '../../../utils/common/helper.dart';

abstract class AuthRepository {
  DataResult<UserModel> login(LoginRequest request);

  DataResult<UserModel> register(RegisterRequest request);

  DataResult<ForgotPasswordModel> forgotPassword(String email);

  DataResult<BasePagingResponse<UserModel>> getListUser(String page, String limit, String? search);

  DataResult<UserModel> getUser(String id);

  DataResult<dynamic> updateUser(UserUpdateRequest request);

}
