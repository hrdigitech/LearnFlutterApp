import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';

class AboutUsController extends GetxController {
  var htmlContent = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchPrivacyPolicy();
  }

  Future<void> fetchPrivacyPolicy() async {
    try {
      var request = await HttpClient().getUrl(Uri.parse('https://customize.hkdigiverse.com/hrcodeexpert/api/about-us'));
      var response = await request.close();

      if (response.statusCode == 200) {
        String responseBody = await response.transform(utf8.decoder).join();
        Map<String, dynamic> jsonResponse = json.decode(responseBody);

        if (jsonResponse['status'] == 1) {
          htmlContent.value = jsonResponse['data'];
        } else {
          throw Exception(jsonResponse['message']);
        }
      } else {
        throw HttpException(response.reasonPhrase);
      }
    } catch (e) {
      htmlContent.value = 'Error: $e';
    }
  }
}