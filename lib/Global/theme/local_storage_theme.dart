import 'package:get_storage/get_storage.dart';

class LocalStorageTheme {
  static const _key = 'app_theme';
  final _box = GetStorage();

  /// light | dark
  String read() {
    return _box.read(_key) ?? 'light';
  }

  void insert(String value) {
    _box.write(_key, value);
  }
}
