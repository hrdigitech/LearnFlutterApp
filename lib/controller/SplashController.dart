import 'package:get/get.dart';
import 'package:learn_flutter/views/routes/AppRoutes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 3), () {
      Get.offAllNamed(AppRoutes.SIGNINSCREEN);
    });
  }
}
