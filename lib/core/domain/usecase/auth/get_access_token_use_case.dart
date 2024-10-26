import 'package:base_flutter_bloc/core/local/datastore/local_storage.dart';

class GetAccessTokenUseCase {
  final LocalStorage _localStorage;

  GetAccessTokenUseCase(this._localStorage);

  Future<String> call() async {
    final token = await _localStorage.getString(LocalStorage.tokenKey);
    return token;
  }
}
