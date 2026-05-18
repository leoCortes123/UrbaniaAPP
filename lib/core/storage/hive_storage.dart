import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
  static late Box<String> _sessionBox;
  static late Box<dynamic> _settingsBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    _sessionBox = await Hive.openBox<String>('session');
    _settingsBox = await Hive.openBox<dynamic>('settings');
  }

  Future<void> write(String key, String value) => _sessionBox.put(key, value);
  Future<String?> read(String key) async => _sessionBox.get(key);
  Future<void> delete(String key) => _sessionBox.delete(key);
  Future<void> clear() async => _sessionBox.clear();
}