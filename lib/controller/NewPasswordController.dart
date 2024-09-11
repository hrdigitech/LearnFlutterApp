import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/views/routes/AppRoutes.dart';

class NewPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  void onContinueOnTap() {
    if (formKey.currentState!.validate()) {
      Get.toNamed(AppRoutes.HOMEPAGE);
    } else {
      Get.snackbar("Error", "Please fill all fields correctly");
    }
  }

  bool isPasswordStrong(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    return true;
  }

  @override
  void onClose() {
    confirmPasswordController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
