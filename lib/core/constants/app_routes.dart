

abstract class AppRoutes {
  AppRoutes._();
  static const registerPage=_Paths.registerPage;
  static const sPLASH = _Paths.sPLASH;
  static const loginpage=_Paths.loginPage;
  static const welcomeScreen=_Paths.welcome;
  static const homePage=_Paths.homePAge;
  static const bookingPage=_Paths.bookingPage;
  static const detailPage=_Paths.detail;
}

abstract class _Paths {
  static const bookingPage='/booking';
  static const homePAge='/home';
  static const registerPage='/register';
  static const loginPage='/login';
  static const sPLASH = "/splash";
  static const welcome='/welcome';
  static const detail='/detail';
}