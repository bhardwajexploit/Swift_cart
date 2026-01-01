import 'package:flutter/animation.dart';
import 'package:foodify/screens/login/login_bindings.dart';
import 'package:foodify/screens/login/login_page.dart';
import '../../screens/Register/register.dart';
import '../../screens/Register/register_bindings.dart';
import '../../screens/dashboard /dashboard_bindings.dart';
import '../../screens/dashboard /dashboard_navigation.dart';
import '../../screens/details/detail_page.dart';
import '../../screens/splash/splash.dart';
import '../../screens/splash/splashbindings.dart';
import '../../screens/welcome/welcomepage.dart';
import '../constants/app_routes.dart';

import 'package:get/get.dart';
class AppPages {
  AppPages._();
  static final routes =[
    GetPage(name: AppRoutes.sPLASH, page: () => Splash(),binding: Splashbindings()),
    GetPage(name: AppRoutes.loginpage, page:() => LoginPage(),binding: LoginBindings(),
     transition: Transition.rightToLeft,                // animation
      transitionDuration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,),
    GetPage(name: AppRoutes.welcomeScreen, page: () => WelcomeScreen()),
    GetPage(name:AppRoutes.registerPage,page: () =>RegisterPage(),binding: RegisterBindings()),
    GetPage(name: AppRoutes.homePage, page: () => DashboardNavigation(),binding: DashboardBindings()),
    GetPage(name: AppRoutes.detailPage, page: () =>ProductDetailPage()),
  ];
}