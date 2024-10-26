import 'package:base_flutter_bloc/core/local/datastore/local_storage.dart';

class SetRefreshTokenUseCase {
  final LocalStorage _localStorage;

  SetRefreshTokenUseCase(this._localStorage);

  Future<void> call(String refreshToken) async {
    await _localStorage.setString(LocalStorage.refreshTokenKey, refreshToken);
  }
}
