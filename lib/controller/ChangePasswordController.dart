import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../views/utils/VarUtils.dart';

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();
  final TextEditingController oldPasswordController = TextEditingController();
  var isLoading = false.obs;

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (!isPasswordStrong(value)) {
      return 'Password must be at least 8 characters long, contain uppercase, lowercase letters, and a number';
    }
    return null;
  }

  bool isPasswordStrong(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    return true;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void onChangePasswordOnTap() async {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      // Prepare the request
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://customize.hkdigiverse.com/hrcodeexpert/api/reset-password'),
      );

      // Add fields to the request
      request.fields.addAll({
        'email': VarUtils.Email,
        'old_password': oldPasswordController.text,
        'new_password': passwordController.text,
        'confirm_password': confirmPasswordController.text,
      });

      // Log request details
      log('Sending Request:');
      log('URL: ${request.url}');
      log('Method: ${request.method}');
      log('Fields: ${request.fields}');

      try {
        http.StreamedResponse response = await request.send();

        // Log response details
        log('Received Response:');
        log('Status Code: ${response.statusCode}');

        String responseBody = await response.stream.bytesToString();
        log('Response Body: $responseBody');

        if (response.statusCode == 200) {
          Get.back(); // Go back on success
        } else {
          Get.snackbar('Oops...', response.reasonPhrase ?? 'An error occurred');
        }
      } catch (e) {
        log('Error: $e');
        Get.snackbar('Oops...', 'Failed to change password. Please try again.');
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    oldPasswordController.dispose();
    super.onClose();
  }
}
