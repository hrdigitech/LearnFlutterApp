import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../views/routes/AppRoutes.dart';
import '../views/utils/VarUtils.dart';

class SignInController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var isLoading = false.obs;

  // Function to handle sign in API request
  Future<void> onSignInTap() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://customize.hkdigiverse.com/hrcodeexpert/api/sign-in'),
    );
    request.fields.addAll({
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

        Get.offNamed(AppRoutes.BOTTOMNAVIGATION);
      } else {
        Get.snackbar("Oops...", responseData['message']);
      }
    } else {
      Get.snackbar("Oops...", "Sign-in failed: ${response.reasonPhrase}");
    }

    isLoading.value = false;
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
