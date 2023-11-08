import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:scr_vendor/common/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:scr_vendor/common/widget/named_navigation_bar_item_widget.dart';
import 'package:scr_vendor/constants/app_route_constants.dart';

/// HomeScreen widget which displays the main screen with a bottom navigation bar.
class HomeScreen extends StatelessWidget {
  final Widget screen;

  HomeScreen({super.key, required this.screen});

  // Making tabs a private member as it's only used within HomeScreen
  final _tabs = [
    NamedNavigationBarItemWidget(
      initialLocation: AppPage.hubs.name,
      icon: const Icon(Icons.hub),
      label: 'Hubs',
    ),
    NamedNavigationBarItemWidget(
      initialLocation: AppPage.cars.name,
      icon: const Icon(Icons.car_crash),
      label: 'Cars',
    ),
    NamedNavigationBarItemWidget(
      initialLocation: AppPage.user.name,
      icon: const Icon(Icons.person_search),
      label: 'Users',
    ),
    NamedNavigationBarItemWidget(
      initialLocation: AppPage.profile.name,
      icon: const Icon(Icons.person),
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen,
      bottomNavigationBar: _buildBottomNavigation(context),
    );
  }

  /// Builds the bottom navigation bar.
  Widget _buildBottomNavigation(BuildContext context) =>
      BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
        buildWhen: (previous, current) => previous.index != current.index,
        builder: (context, state) {
          return BottomNavigationBar(
            onTap: (index) => _onNavItemTapped(context, state, index),
            showSelectedLabels: false,
            showUnselectedLabels: false,
            elevation: 0,
            backgroundColor: Colors.black,
            unselectedItemColor: Colors.white,
            selectedIconTheme: IconThemeData(
              size: (IconTheme.of(context).size ?? 24) * 1.3,
            ),
            items: _tabs,
            currentIndex: state.index,
            type: BottomNavigationBarType.fixed,
          );
        },
      );

  /// Handles the navigation item tap.
  void _onNavItemTapped(
      BuildContext context, BottomNavigationState state, int index) {
    if (state.index != index) {
      context.read<BottomNavigationCubit>().selectNavBarItem(index);
      context.goNamed(_tabs[index].initialLocation);
    }
  }
}
