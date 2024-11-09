import 'package:base_flutter_bloc/core/model/data/remote/response/auth/user_model.dart';
import 'package:base_flutter_bloc/core/utils/common/helper.dart';

import '../../../model/data/remote/response/base_paging_response.dart';
import '../../repository/auth/auth_repository.dart';

class GetListUserUseCase {
  final AuthRepository _authRepository;

  GetListUserUseCase(
    this._authRepository,
  );

  DataResult<BasePagingResponse<UserModel>> call({
    required String page,
    required String limit,
    String? search,
  }) async {
    return await _authRepository.getListUser(
      page,
      limit,
      search,
    );
  }
}
