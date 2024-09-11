import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/views/routes/AppRoutes.dart';

class ForgetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController mailController = TextEditingController();

  void onForgetPasswordOnTap() {
    if (formKey.currentState!.validate()) {
      Get.toNamed(AppRoutes.ENTERCODEPAGE);
    } else {
      Get.snackbar("Error", "Please fill all fields correctly");
    }
  }

  @override
  void onClose() {
    mailController.dispose();
    super.onClose();
  }
}
