import '../../../local/datastore/local_storage.dart';

class SetAccessTokenUseCase {
  final LocalStorage _localStorage;

  SetAccessTokenUseCase(this._localStorage);

  Future<void> call(String token) async {
    await _localStorage.setString(LocalStorage.tokenKey, token);
  }
}