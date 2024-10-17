import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LatestItem {
  final int id;
  final String thumbnail;
  final String title;
  final int view;
  final int like;
  final int comment;
  final int followers;
  final String description;
  final String youtubeLink;
  final String createdAt;
  final int playlistId;
  final String playlist_name;

  LatestItem({
    required this.id,
    required this.thumbnail,
    required this.title,
    required this.view,
    required this.like,
    required this.comment,
    required this.followers,
    required this.description,
    required this.youtubeLink,
    required this.createdAt,
    required this.playlistId,
    required this.playlist_name,
  });

  factory LatestItem.fromJson(Map<String, dynamic> json) {
    return LatestItem(
      id: json['id'],
      thumbnail: json['thumbnail'] ?? '',
      title: json['title'] ?? '',
      view: json['view'] ?? 0,
      like: json['like'] ?? 0,
      comment: json['comment'] ?? 0,
      followers: json['followers'] ?? 0,
      description: json['description'] ?? '',
      youtubeLink: json['youtube_link'] ?? '',
      createdAt: json['created_at'] ?? '',
      playlistId: json['playlist_id'] ?? 0,
      playlist_name: json['playlist_name'],
    );
  }
}

class LatestController extends GetxController {
  var latestList = <LatestItem>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchLatestPlaylist();
    super.onInit();
  }

  Future<void> fetchLatestPlaylist() async {
    try {
      isLoading(true);
      var request = http.Request('GET', Uri.parse('https://customize.hkdigiverse.com/hrcodeexpert/api/latest-playlist'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String jsonResponse = await response.stream.bytesToString();
        var data = json.decode(jsonResponse)['data'] as List;

        latestList.value = data.map((item) => LatestItem.fromJson(item)).toList();
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
