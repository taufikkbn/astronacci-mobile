import 'package:base_flutter_bloc/core/model/data/remote/request/auth/user_update_request.dart';

import '../../../utils/common/helper.dart';
import '../../repository/auth/auth_repository.dart';

class UserUpdateUseCase {
  final AuthRepository _authRepository;

  UserUpdateUseCase(this._authRepository);

  DataResult<dynamic> call(
    UserUpdateRequest request,
  ) async {
    return await _authRepository.updateUser(request);
  }
}
