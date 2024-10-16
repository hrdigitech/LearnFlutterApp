import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../views/routes/AppRoutes.dart';

class ForgetPasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController mailController = TextEditingController();
  var isLoading = false.obs;

  // API request for Forget Password
  Future<void> onForgetPasswordTap() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://customize.hkdigiverse.com/hrcodeexpert/api/forget-pwd'),
    );
    request.fields.addAll({
      'email': mailController.text,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonResponse = await response.stream.bytesToString();
      var responseData = json.decode(jsonResponse);

      if (responseData['status'] == 1) {
        // Success: OTP sent
        Get.snackbar("Success", responseData['message']);

        // Pass the email to the next page
        Get.toNamed(AppRoutes.ENTERCODEPAGE, arguments: {
          'email': mailController.text,
        });
      } else {
        // Failure: Email not registered
        Get.snackbar("Oops...", responseData['message']);
      }
    } else {
      Get.snackbar("Oops...", "Request failed: ${response.reasonPhrase}");
    }

    isLoading.value = false;
  }

  @override
  void onClose() {
    mailController.dispose();
    super.onClose();
  }
}
