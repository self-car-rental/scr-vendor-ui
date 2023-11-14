// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:scr_vendor/core/themes/app_theme.dart';

class ThemePreferenceService {
  static const _boxName = 'themePreferences';
  static const _key = 'selectedTheme';

  Future<void> setSelectedTheme(AppTheme theme) async {
    var box = await Hive.openBox(_boxName);
    await box.put(_key, theme.toString().split('.').last);
  }

  Future<AppTheme> getSelectedTheme() async {
    var box = await Hive.openBox(_boxName);
    String themeStr = box.get(_key,
        defaultValue: AppTheme.lightTheme.toString().split('.').last);
    return AppTheme.values.firstWhere(
        (e) => e.toString().split('.').last == themeStr,
        orElse: () => AppTheme.darkTheme);
  }
}
