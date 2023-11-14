// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// Project imports:
import 'package:scr_vendor/common/widgets/named_navigation_bar_item_widget.dart';
import 'package:scr_vendor/constants/app_route_constants.dart';
import 'package:scr_vendor/core/bottom_navigation/bottom_navigation_cubit.dart';
import 'package:scr_vendor/core/utils/app_extension.dart';

class HomeScreen extends StatelessWidget {
  final Widget screen;

  const HomeScreen({super.key, required this.screen});

  @override
  Widget build(BuildContext context) {
    final List<NamedNavigationBarItemWidget> tabs = _buildTabs(context);
    return Scaffold(
      body: screen,
      bottomNavigationBar: _buildBottomNavigation(context, tabs),
    );
  }

  List<NamedNavigationBarItemWidget> _buildTabs(BuildContext context) {
    return [
      NamedNavigationBarItemWidget(
        initialLocation: AppRoutes.name(AppPage.hubs),
        icon: const Icon(Icons.hub),
        label: context.tr.bottomNavHubs,
      ),
      NamedNavigationBarItemWidget(
        initialLocation: AppRoutes.name(AppPage.cars),
        icon: const Icon(Icons.car_crash),
        label: context.tr.bottomNavCars,
      ),
      NamedNavigationBarItemWidget(
        initialLocation: AppRoutes.name(AppPage.users),
        icon: const Icon(Icons.person_search),
        label: context.tr.bottomNavUsers,
      ),
      NamedNavigationBarItemWidget(
        initialLocation: AppRoutes.name(AppPage.profile),
        icon: const Icon(Icons.person),
        label: context.tr.bottomNavProfile,
      ),
    ];
  }

  Widget _buildBottomNavigation(
      BuildContext context, List<NamedNavigationBarItemWidget> tabs) {
    return BlocBuilder<BottomNavigationCubit, BottomNavigationState>(
      buildWhen: (previous, current) => previous.index != current.index,
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex: state.index,
          onTap: (index) => _onNavItemTapped(context, state, tabs, index),
          showSelectedLabels: true,
          items: tabs,
        );
      },
    );
  }

  void _onNavItemTapped(
    BuildContext context,
    BottomNavigationState state,
    List<NamedNavigationBarItemWidget> tabs,
    int index,
  ) {
    if (state.index != index) {
      context.read<BottomNavigationCubit>().selectNavBarItem(index);
      context.goNamed(tabs[index].initialLocation);
    }
  }
}
