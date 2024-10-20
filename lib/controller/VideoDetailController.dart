import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VideoDetailController extends GetxController {
  var videoDetail = {}.obs;
  var isLoading = true.obs;
  var isLike = false.obs;
  var previewImages = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    final String videoId = args['videoId'].toString();
    final String userId = args['userId'].toString();
    fetchVideoDetail(videoId, userId);
  }

  Future<void> fetchVideoDetail(String id, String userId) async {
    log("Video Id: ${id.toString()}, User Id: ${userId.toString()}");
    try {
      isLoading(true);
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://customize.hkdigiverse.com/hrcodeexpert/api/video-detail'),
      );
      request.fields.addAll({
        'id': id,
        'user_id': userId,
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(await response.stream.bytesToString());
        var data = jsonResponse['data'];

        videoDetail.value = data;
        isLike.value = jsonResponse['islike'];

        // Parsing preview images
        var previewStr = data['preview_img'];
        if (previewStr is List) {
          previewImages.value = previewStr
              .map((img) => 'https://customize.hkdigiverse.com/hrcodeexpert/storage/app/public/video/preview/$img')
              .toList();
        } else if (previewStr is String) {
          previewImages.value = previewStr
              .split(',')
              .map((img) => 'https://customize.hkdigiverse.com/hrcodeexpert/storage/app/public/video/preview/$img')
              .toList();
        }
      } else {
        log('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      log('Error fetching video detail: $e');
    } finally {
      isLoading(false);
    }
  }
}
