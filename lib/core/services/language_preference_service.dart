// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:scr_vendor/constants/language_constants.dart';

class LanguagePreferenceService {
  static const _boxName = 'languagePreferences';
  static const _key = 'selectedLanguage';

  Future<String> getSelectedLanguage() async {
    var box = await Hive.openBox(_boxName);
    return box.get(_key, defaultValue: LanguageConstants.languages.keys.first);
  }

  Future<void> setSelectedLanguage(String languageCode) async {
    var box = await Hive.openBox(_boxName);
    await box.put(_key, languageCode);
  }
}
