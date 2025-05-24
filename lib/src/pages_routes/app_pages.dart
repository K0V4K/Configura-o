import 'package:flutter_application/src/auth/sign_in_screen.dart';
import 'package:flutter_application/src/auth/sign_up_screen.dart';
import 'package:flutter_application/src/base/base_screen.dart';
import 'package:flutter_application/src/pages/admin_tab.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = <GetPage>[
    GetPage(page: () => SignInScreen(), name: PagesRoutes.signInRoute),
    GetPage(page: () => SignUpScreen(), name: PagesRoutes.signUpRoute),
    GetPage(page: () => BaseScreen(), name: PagesRoutes.BaseRoute),
    GetPage(page: () => AdminTabScreen(), name: PagesRoutes.adminTabRoute),
  ];
}

abstract class PagesRoutes {
  static const String signInRoute = '/singin';
  static const String signUpRoute = '/singup';
  static const String BaseRoute = '/baseScreen';
  static const String adminTabRoute = '/admin';
}
