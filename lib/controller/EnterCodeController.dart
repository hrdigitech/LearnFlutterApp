import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/routes/AppRoutes.dart';

class EnterCodeController extends GetxController{
  late TextEditingController pinEditingController;

  @override
  void onInit() {
    super.onInit();
    pinEditingController = TextEditingController();
  }

  void onVerifyOnTap() {
    Get.toNamed(AppRoutes.NEWPASSWORDPAGE);
  }

  @override
  void onClose() {
    super.onClose();
    pinEditingController.dispose();
  }
}