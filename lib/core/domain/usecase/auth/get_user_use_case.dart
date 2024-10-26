import 'package:base_flutter_bloc/core/model/data/remote/response/auth/user_model.dart';
import 'package:base_flutter_bloc/core/utils/common/helper.dart';

import '../../repository/auth/auth_repository.dart';

class GetUserUseCase {
  final AuthRepository _authRepository;

  GetUserUseCase(this._authRepository);

  DataResult<UserModel> call() async {
    return await _authRepository.getUser();
  }
}
