import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/views/routes/AppRoutes.dart';

class SignInController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void onSignInTap() {
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
    mailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
