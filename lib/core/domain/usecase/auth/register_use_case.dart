import 'package:base_flutter_bloc/core/model/data/remote/request/auth/register_request.dart';

import '../../../model/data/remote/response/auth/user_model.dart';
import '../../../utils/common/helper.dart';
import '../../repository/auth/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository _authRepository;

  RegisterUseCase(this._authRepository);

  DataResult<UserModel> call(
    RegisterRequest request,
  ) async {
    return await _authRepository.register(request);
  }
}
