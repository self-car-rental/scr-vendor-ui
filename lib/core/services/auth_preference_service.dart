// Package imports:
import 'package:hive/hive.dart';

class AuthPreferenceService {
  static const _boxName = 'userPreferences';
  static const _isLoggedInKey = 'isLoggedIn';

  Future<bool> isLoggedIn() async {
    var box = await Hive.openBox(_boxName);
    return box.get(_isLoggedInKey, defaultValue: false);
  }

  Future<void> setLoggedIn(bool loggedIn) async {
    var box = await Hive.openBox(_boxName);
    await box.put(_isLoggedInKey, loggedIn);
  }
}
