import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/views/routes/AppRoutes.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Text controllers for the form fields
  final TextEditingController mailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Validator methods for each field
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    } else if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!GetUtils.isPhoneNumber(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

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

  // Method to handle Sign Up tap
  void onSignUpTap() {
    if (formKey.currentState!.validate()) {
      Get.toNamed(AppRoutes.HOMEPAGE);
    } else {
      Get.snackbar("Error", "Please fill all fields correctly");
    }
  }

  @override
  void onClose() {
    mailController.dispose();
    passwordController.dispose();
    contactController.dispose();
    usernameController.dispose();
    super.onClose();
  }
}
