/// This file defines the BottomNavigationCubit which manages the state
/// for the bottom navigation bar in the app.
library;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scr_vendor/constants/app_route_constants.dart';

part 'bottom_navigation_state.dart';

/// Manages the state of the bottom navigation bar.
class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit()
      : super(
            BottomNavigationState(bottomNavItem: AppPage.hubs.name, index: 0));

  /// Selects a navigation bar item based on the given [index].
  void selectNavBarItem(int index) {
    switch (index) {
      case 0:
        emit(BottomNavigationState(bottomNavItem: AppPage.hubs.name, index: 0));
        break;
      case 1:
        emit(BottomNavigationState(bottomNavItem: AppPage.cars.name, index: 1));
        break;
      case 2:
        emit(BottomNavigationState(bottomNavItem: AppPage.user.name, index: 2));
        break;
      case 3:
        emit(BottomNavigationState(
            bottomNavItem: AppPage.profile.name, index: 3));
        break;
      default:
        // Consider logging an error or using an assertion in development mode.
        break;
    }
  }
}
