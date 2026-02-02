import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colours.dart';
import '../home/home_page.dart';
import '../cart/cart_page.dart';
import '../profile /profile_screen.dart';
import 'dashboard_controller.dart';

class DashboardNavigation extends GetView<DashboardController> {
  const DashboardNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        inactiveColor: CupertinoColors.black.withValues(alpha: 0.7),
        activeColor: AppColours.kPrimaryPurple,
        backgroundColor: CupertinoColors.white.withValues(alpha: 0.7),
        currentIndex: controller.tabIndex.value,
        onTap: controller.changeTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.person),
            label: 'Profile',
          ),
        ],
      ),
      tabBuilder: (context, index) {
        return CupertinoTabView(
          builder: (context) {
            switch (index) {
              case 0:
                return const HomePage();
              case 1:
                return const CartPage();
              case 2:
                return const ProfileScreen();
              default:
                return const HomePage();
            }
          },
        );
      },
    );
  }
}
