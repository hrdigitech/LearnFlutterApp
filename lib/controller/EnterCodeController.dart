import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../views/routes/AppRoutes.dart';

class EnterCodeController extends GetxController {
  late TextEditingController pinEditingController;
  var isLoading = false.obs;
  late String email;

  @override
  void onInit() {
    super.onInit();
    pinEditingController = TextEditingController();
    email = Get.arguments['email'];
  }

  Future<void> onVerifyOnTap() async {
    if (pinEditingController.text.length == 6) {
      isLoading.value = true;

      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'https://customize.hkdigiverse.com/hrcodeexpert/api/verifyOtp'));
      request.fields.addAll({
        'email': email,
        'otp': pinEditingController.text,
      });

      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        var result = await response.stream.bytesToString();
        log("API Response: $result");
        var jsonResponse = json.decode(result);
        if (jsonResponse['status'] == 1) {
          Get.toNamed(AppRoutes.NEWPASSWORDPAGE, arguments: {
            'email': email,
          });
        } else {
          Get.snackbar("Error",
              jsonResponse['message'] ?? "Invalid OTP, please try again");
        }
      } else {
        Get.snackbar("Error", "Failed to verify OTP, please try again");
      }

      isLoading.value = false;
    } else {
      Get.snackbar("Error", "Please enter a 6-digit OTP");
    }
  }

  Future<void> resendOtp() async {
    isLoading.value = true;

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://customize.hkdigiverse.com/hrcodeexpert/api/forget-pwd'),
    );
    request.fields.addAll({
      'email': email,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String jsonResponse = await response.stream.bytesToString();
      var responseData = json.decode(jsonResponse);

      if (responseData['status'] == 1) {
        Get.snackbar("Success", responseData['message']);
      } else {
        Get.snackbar("Oops...", responseData['message']);
      }
    } else {
      Get.snackbar("Oops...", "Request failed: ${response.reasonPhrase}");
    }

    isLoading.value = false;
  }

  @override
  void onClose() {
    super.onClose();
    pinEditingController.dispose();
  }
}
