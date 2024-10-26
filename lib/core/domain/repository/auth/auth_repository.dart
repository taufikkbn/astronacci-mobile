import 'package:base_flutter_bloc/core/model/data/remote/request/auth/auth_request.dart';
import 'package:base_flutter_bloc/core/model/data/remote/response/auth/user_model.dart';

import '../../../model/data/remote/request/auth/refresh_token_request.dart';
import '../../../model/data/remote/response/auth/token_model.dart';
import '../../../utils/common/helper.dart';

abstract class AuthRepository {
  DataResult<UserModel> login(LoginRequest request);

  DataResult<UserModel> getUser();

  DataResult<TokenModel> refreshToken(RefreshTokenRequest request);
}
