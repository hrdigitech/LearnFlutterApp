import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/PlaylistItem.dart';

class PlaylistController extends GetxController {
  var playlist = <PlaylistItem>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchPlaylist();
    super.onInit();
  }

  Future<void> fetchPlaylist() async {
    try {
      isLoading(true);
      var request = http.Request('GET', Uri.parse('https://customize.hkdigiverse.com/hrcodeexpert/api/all-playlist'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String jsonResponse = await response.stream.bytesToString();
        var data = json.decode(jsonResponse)['data'] as List;

        playlist.value = data.map((item) => PlaylistItem.fromJson(item)).toList();
      } else {
        errorMessage('Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      errorMessage('Error: $e');
    } finally {
      isLoading(false);
    }
  }
}
