import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:learn_flutter/views/routes/AppRoutes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? email = prefs.getString('Email');
    int? userId = prefs.getInt('ID');
    print('Retrieved Email: $email, UserID: $userId');

    if (email != null && userId != null) {
      Get.offAllNamed(AppRoutes.BOTTOMNAVIGATION);
    } else {
      // Delay before navigating to SignInScreen
      // Get.offAllNamed(AppRoutes.SIGNINSCREEN);

      Future.delayed(Duration(seconds: 3), () {
        Get.offAllNamed(AppRoutes.SIGNINSCREEN);
      });
    }
  }
}
