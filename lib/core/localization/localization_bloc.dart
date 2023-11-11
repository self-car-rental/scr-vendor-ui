// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:scr_vendor/constants/language_constants.dart';
import 'package:scr_vendor/core/localization/localization_event.dart';

class LocalizationBloc extends Bloc<LocalizationEvent, Locale> {
  LocalizationBloc() : super(Locale(LanguageConstants.languages.keys.first)) {
    on<LocalizationEvent>((event, emit) {
      emit(event.locale);
    });
  }
}
