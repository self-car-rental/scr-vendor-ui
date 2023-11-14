// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:scr_vendor/core/themes/app_theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeState.initial()) {
    on<ThemeEvent>((event, emit) => _handleThemeChange(event, emit));
  }

  void _handleThemeChange(ThemeEvent event, Emitter<ThemeState> emit) {
    final newTheme = _isLightTheme
        ? AppThemes.appThemeData[AppTheme.darkTheme]
        : AppThemes.appThemeData[AppTheme.lightTheme];
    emit(ThemeState(theme: newTheme!));
  }

  bool get _isLightTheme {
    return state.theme == AppThemes.appThemeData[AppTheme.lightTheme];
  }
}
