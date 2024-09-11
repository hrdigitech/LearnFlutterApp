import 'package:get/get.dart';
import 'package:learn_flutter/views/screens/EnterCodePage.dart';
import 'package:learn_flutter/views/screens/ForgetPassword.dart';
import 'package:learn_flutter/views/screens/NewPasswordPage.dart';
import 'package:learn_flutter/views/screens/SignInScreen.dart';
import 'package:learn_flutter/views/screens/SignUpScreen.dart';

import '../screens/HomePage.dart';
import '../screens/SplashScreen.dart';

class AppRoutes {
  static const String SPLASH = "/";
  static const String HOMEPAGE = "/home";
  static const String SIGNINSCREEN = "/sign_in_screen";
  static const String SIGNUPSCREEN = "/sign_up_screen";
  static const String FORGETPASSWORD = "/forget_password";
  static const String ENTERCODEPAGE = "/enter_code_page";
  static const String NEWPASSWORDPAGE = "/new_password_page";

  static final routes = [
    GetPage(
      name: SPLASH,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: SIGNINSCREEN,
      page: () => SignInScreen(),
    ),
    GetPage(
      name: SIGNUPSCREEN,
      page: () => SignUpScreen(),
    ),
    GetPage(
      name: FORGETPASSWORD,
      page: () => ForgetPassword(),
    ),
    GetPage(
      name: ENTERCODEPAGE,
      page: () => EnterCodePage(),
    ),
    GetPage(
      name: NEWPASSWORDPAGE,
      page: () => NewPasswordPage(),
    ),
    GetPage(
      name: HOMEPAGE,
      page: () => HomePage(),
    ),
  ];
}
