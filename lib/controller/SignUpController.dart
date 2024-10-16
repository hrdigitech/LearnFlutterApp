import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../views/routes/AppRoutes.dart';
import '../views/utils/VarUtils.dart';

class SignUpController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // Text controllers for the form fields
  final TextEditingController mailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;

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

  // API request for sign up
  Future<void> onSignUpTap() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://customize.hkdigiverse.com/hrcodeexpert/api/sign-up'),
    );
    request.fields.addAll({
      'mobile_no': contactController.text,
      'name': usernameController.text,
      'email': mailController.text,
      'password': passwordController.text,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonResponse = await response.stream.bytesToString();
      var responseData = json.decode(jsonResponse);

      if (responseData['status'] == 1) {
        var data = responseData['data'];

        // Save data to VarUtils
        VarUtils.Email = data['email'];
        VarUtils.Name = data['username'];
        VarUtils.ID = data['id'];
        VarUtils.Password = passwordController.text;
        VarUtils.phoneNumber = data['phone'].toString();
        VarUtils.ProfileImage = data['profile_image'] ?? '';

        // Save data to SharedPreferences
        await VarUtils.saveVariablesSignInToPrefs();

        // Clear input fields
        mailController.clear();
        passwordController.clear();
        contactController.clear();
        usernameController.clear();

        Get.offNamed(AppRoutes.BOTTOMNAVIGATION);
      } else {
        Get.snackbar("Oops...", responseData['message']);
      }
    } else {
      Get.snackbar("Oops...", "Sign-up failed: ${response.reasonPhrase}");
    }

    isLoading.value = false;
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
