abstract class LocalStorage {
  /// Store String
  Future setString(String key, String token);

  Future<String> getString(String key);

  /// Store Bool
  Future setBool(String key, bool value);

  Future<bool> getBool(String key);

  /// Common
  Future deleteKey(String key);

  Future closeLocalStorage();

  static const tokenKey = "token_key";
  static const refreshTokenKey = "refresh_token";

  static const localStorageKey = "local_storage_box";
}
