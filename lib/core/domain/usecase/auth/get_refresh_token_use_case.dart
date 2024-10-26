import 'package:base_flutter_bloc/core/local/datastore/local_storage.dart';

class GetRefreshTokenUseCase {
  final LocalStorage _localStorage;

  GetRefreshTokenUseCase(this._localStorage);

  Future<String> call() async {
    final refreshToken = await _localStorage.getString(LocalStorage.refreshTokenKey);
    return refreshToken;
  }
}
