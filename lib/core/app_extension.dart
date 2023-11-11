// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// Project imports:
import 'package:scr_vendor/core/app_asset.dart';

extension StringExtension on String {
  String get getGenderWidget {
    if (this == 'male') return AppAsset.male;
    return AppAsset.female;
  }

  String get toCapital {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}

extension IntegerExtension on int? {
  bool get success {
    if (this == 200 || this == 201 || this == 204) {
      return true;
    }
    return false;
  }
}

extension GeneralExtension<T> on T {
  bool get isEnum {
    final split = toString().split('.');
    return split.length > 1 && split[0] == runtimeType.toString();
  }

  String get getEnumString => toString().split('.').last.toCapital;
}

extension IterableExtension<T> on Iterable<T> {
  Iterable<E> mapWithIndex<E>(E Function(int index, T value) f) {
    return Iterable.generate(length).map((i) => f(i, elementAt(i)));
  }
}

extension MapExtension on Map {
  String get format {
    if (isEmpty) {
      return '';
    } else {
      var firstKey = entries.first.key;
      var mapValues = entries.first.value;
      return '?$firstKey=$mapValues';
    }
  }
}

//Helper functions
void pop(BuildContext context, int returnedLevel) {
  for (var i = 0; i < returnedLevel; ++i) {
    Navigator.of(context, rootNavigator: true).pop(true);
  }
}

/// Extension on BuildContext to simplify localization access.
/// 'tr' is shorthand for 'translate' - used to fetch localized strings.
extension LocalizationExtension on BuildContext {
  AppLocalizations get tr => AppLocalizations.of(this)!; // 'tr' for translation
}
