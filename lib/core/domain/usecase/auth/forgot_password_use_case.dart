import '../../../utils/common/helper.dart';
import '../../repository/auth/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository _authRepository;

  ForgotPasswordUseCase(this._authRepository);

  DataResult<dynamic> call(String email) async {
    return await _authRepository.forgotPassword(email);
  }
}
