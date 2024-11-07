import 'package:base_flutter_bloc/core/model/data/remote/request/auth/auth_request.dart';
import 'package:base_flutter_bloc/core/model/data/remote/response/auth/user_model.dart';
import 'package:base_flutter_bloc/core/utils/common/helper.dart';

import '../../repository/auth/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCase(this._authRepository);

  DataResult<UserModel> call(String email, String password) async {
    final request = LoginRequest(
      email: email,
      password: password,
    );
    return await _authRepository.login(request);
  }
}
