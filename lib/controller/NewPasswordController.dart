import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/views/routes/AppRoutes.dart';

class NewPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  var isLoading = false.obs;

  void onContinueOnTap() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      String email = Get.arguments['email'];
      String newPassword = passwordController.text;
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://customize.hkdigiverse.com/hrcodeexpert/api/change-password'));
      request.fields.addAll({
        'email': email,
        'new_password': newPassword,
        'confirm_password': newPassword
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        var jsonResponse = json.decode(result);

        if (jsonResponse['status'] == 1) {
          Get.snackbar("Success", "Password reset successfully");
          Get.toNamed(AppRoutes.HOMEPAGE); // Navigate to homepage after success
        } else {
          Get.snackbar("Oops...", jsonResponse['message']);
        }
      } else {
        Get.snackbar(
            "Oops...", "Failed to reset password: ${response.reasonPhrase}");
      }

      isLoading.value = false; // Reset loading state
    } else {
      Get.snackbar("Oops...", "Please fill all fields correctly");
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
