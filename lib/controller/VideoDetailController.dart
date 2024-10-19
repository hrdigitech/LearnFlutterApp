import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:learn_flutter/models/VideoDetailsModel.dart';

import '../views/utils/VarUtils.dart';

class VideoDetailController extends GetxController {
  var isLoading = false.obs;
  VideoDetailsModel? _videoDetailsModel;
  VideoDetailsModel? get videoDetailsModel => _videoDetailsModel;
  set videoDetailsModel(VideoDetailsModel? value) {
    _videoDetailsModel = value;
    update();
  }

  var videoId = ''.obs; // Observed variable for video ID

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      videoId.value = Get.arguments.toString();
      fetchVideoDetail(videoId: int.parse(videoId.value));
    }
  }

  var previewImages = [
    "https://i.ytimg.com/vi/TTNdGjl0wqo/maxresdefault.jpg",
    "https://img.freepik.com/free-vector/bright-gradient-background-geometric-colorful_361591-4630.jpg",
    "https://g3.img-dpreview.com/429FE12F3580437897F4F0C2379386C6.jpg",
    "https://img.freepik.com/free-vector/green-neon-synthwave-patterned-social-story-template-vector_53876-173387.jpg?size=626&ext=jpg&ga=GA1.1.2008272138.1726012800&semt=ais_hybrid",
    "https://g1.img-dpreview.com/3ACBE6D011274856888F900E563D7A85.jpg",
  ].obs;

  Future<void> fetchVideoDetail({required int videoId}) async {
    try {
      isLoading(true);

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://customize.hkdigiverse.com/hrcodeexpert/api/video-detail'),
      );

      request.fields['id'] = videoId.toString(); // Pass the video ID
      request.fields['user_id'] = VarUtils.ID.toString(); // Assuming you have a user ID stored in VarUtils

      print('Request URL: ${request.url}');
      print('Request Fields: ${request.fields}');

      var response = await request.send();
      print('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);
        print('JSON Response: $jsonResponse');

        // Check if the response indicates success
        if (jsonResponse['status'] == 1) {
          VideoDetailsModel data = VideoDetailsModel.fromJson(jsonResponse);
         videoDetailsModel = data;

          Get.snackbar('Success', 'Video details fetched successfully');
        } else {
          Get.snackbar('Error', jsonResponse['message'] ?? 'Something went wrong');
        }
      } else {
        Get.snackbar("Error", "Failed to fetch video details");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: ${e.toString()}");
    } finally {
      isLoading(false);
    }
  }

}
