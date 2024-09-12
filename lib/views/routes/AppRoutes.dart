import 'package:get/get.dart';
import 'package:learn_flutter/views/screens/BottomNavigationPage.dart';
import 'package:learn_flutter/views/screens/EnterCodePage.dart';
import 'package:learn_flutter/views/screens/ForgetPassword.dart';
import 'package:learn_flutter/views/screens/LatestPage.dart';
import 'package:learn_flutter/views/screens/NewPasswordPage.dart';
import 'package:learn_flutter/views/screens/PlaylistDetailPage.dart';
import 'package:learn_flutter/views/screens/PlaylistPage.dart';
import 'package:learn_flutter/views/screens/SignInScreen.dart';
import 'package:learn_flutter/views/screens/SignUpScreen.dart';
import 'package:learn_flutter/views/screens/TrendingPage.dart';
import 'package:learn_flutter/views/screens/VideoDetailsPage.dart';

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
  static const String BOTTOMNAVIGATION = "/bottom_navigation_page";
  static const String PLAYLISTPAGE = "/playlist_page";
  static const String PLAYLISTDETAILPAGE = "/playlist_detail_page";
  static const String LATESTPAGE = "/latest_page";
  static const String TRENDINGPAGE = "/trending_page";
  static const String VIDEODETAILPAGE = "/video_detail_page";

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
    GetPage(
      name: BOTTOMNAVIGATION,
      page: () => BottomNavigationPage(),
    ),
    GetPage(
      name: PLAYLISTPAGE,
      page: () => PlaylistPage(),
    ),
    GetPage(
      name: PLAYLISTDETAILPAGE,
      page: () => PlaylistDetailPage(),
    ),
    GetPage(
      name: LATESTPAGE,
      page: () => LatestPage(),
    ),
    GetPage(
      name: TRENDINGPAGE,
      page: () => TrendingPage(),
    ),
    GetPage(
      name: VIDEODETAILPAGE,
      page: () => VideoDetailsPage(),
    ),
  ];
}
