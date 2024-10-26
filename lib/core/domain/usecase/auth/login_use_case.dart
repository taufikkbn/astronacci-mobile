import 'package:base_flutter_bloc/core/model/data/remote/request/auth/auth_request.dart';
import 'package:base_flutter_bloc/core/model/data/remote/response/auth/user_model.dart';
import 'package:base_flutter_bloc/core/utils/common/helper.dart';

import '../../repository/auth/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  DataResult<UserModel> call(String username, String password, int time) async {
    final request = LoginRequest(
      username: username,
      password: password,
      expiresInMins: time.toString(),
    );
    return await _authRepository.login(request);
  }
}
