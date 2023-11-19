// Package imports:
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Project imports:
import 'package:scr_vendor_ui/constants/app_route_constants.dart';

part 'bottom_navigation_state.dart';

class BottomNavigationCubit extends Cubit<BottomNavigationState> {
  BottomNavigationCubit()
      : super(BottomNavigationState(
            bottomNavItem: AppRoutes.name(AppPage.hubs), index: 0));

  void selectNavBarItem(int index) {
    String navItem;
    switch (index) {
      case 0:
        navItem = AppRoutes.name(AppPage.hubs);
        break;
      case 1:
        navItem = AppRoutes.name(AppPage.cars);
        break;
      case 2:
        navItem = AppRoutes.name(AppPage.users);
        break;
      case 3:
        navItem = AppRoutes.name(AppPage.profile);
        break;
      default:
        return; // Optionally add error handling or logging here
    }
    emit(BottomNavigationState(bottomNavItem: navItem, index: index));
  }
}
