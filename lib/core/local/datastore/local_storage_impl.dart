import 'package:hive/hive.dart';

import 'local_storage.dart';

class LocalStorageImpl implements LocalStorage {
  Box? _cachedBox;

  Future<Box> get _box async {
    if (_cachedBox != null && _cachedBox!.isOpen) return _cachedBox!;
    _cachedBox = await Hive.openBox(LocalStorage.localStorageKey);
    return _cachedBox!;
  }

  @override
  Future<String> getString(String key) async {
    final box = await _box;
    return await box.get(key, defaultValue: "");
  }

  @override
  Future setString(String key, String token) async {
    final box = await _box;
    await box.put(key, token);
  }

  @override
  Future<bool> getBool(String key) async {
    final box = await _box;
    return await box.get(key, defaultValue: false);
  }

  @override
  Future setBool(String key, bool value) async {
    final box = await _box;
    await box.put(key, value);
  }

  @override
  Future deleteKey(String key) async {
    final box = await _box;
    await box.delete(key);
  }

  @override
  Future closeLocalStorage() async {
    if (_cachedBox != null && _cachedBox!.isOpen) {
      await _cachedBox!.close();
      _cachedBox = null; // Clear the cached box after closing
    }
  }
}
