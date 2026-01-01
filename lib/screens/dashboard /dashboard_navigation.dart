import 'package:flutter/cupertino.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import '../cart/cart_page.dart';
import '../home/home_page.dart';
import '../profile /profile_screen.dart';
import 'dashboard_controller.dart';

class DashboardNavigation extends GetView<DashboardController> {
  const DashboardNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) => CupertinoTabScaffold(
        controller: controller.tabController,  // Key fix!
        tabBar: CupertinoTabBar(
          currentIndex: controller.tabIndex.value,
          onTap: controller.changeTab,
          activeColor: CupertinoColors.systemPurple,
          inactiveColor: CupertinoColors.systemGrey,
          items: const [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.shopping_cart), label: 'Cart'),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_solid), label: 'Profile'),
          ],
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            builder: (context) => switch (index) {
              0 => HomePage(),
              1 => CartPage(),
              2 => ProfileScreen(),
              _ => HomePage(),
            },
          );
        },
      ),
    );
  }
}
