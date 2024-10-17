import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

import '../models/PlaylistDetailItem.dart';

class DetailPlaylistController extends GetxController {
  var playlistDetails = <PlaylistDetailsItem>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  Future<void> fetchPlaylistDetails(String playlistId) async {
    try {
      isLoading(true);
      log('Fetching playlist details for ID: $playlistId');

      var request = http.MultipartRequest(
          'POST',
          Uri.parse('https://customize.hkdigiverse.com/hrcodeexpert/api/playlist-detail')
      );
      request.fields.addAll({'id': playlistId});

      http.StreamedResponse response = await request.send();

      log('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        String jsonResponse = await response.stream.bytesToString();
        log('Response data: $jsonResponse');

        var data = json.decode(jsonResponse)['data']['playlist']['videos'] as List;

        playlistDetails.value = data.map((item) => PlaylistDetailsItem.fromJson(item)).toList(); // Update playlist details
        log('Playlist details updated successfully');
      } else {
        errorMessage('Failed to fetch playlist details. Status code: ${response.statusCode}');
        log('Error: ${errorMessage.value}');
      }
    } catch (e) {
      errorMessage('Error: $e');
      log('Exception: $e');
    } finally {
      isLoading(false);
    }
  }

}
