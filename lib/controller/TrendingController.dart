import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:learn_flutter/views/utils/VarUtils.dart';

class TrendingItem {
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
  final String playlist_name;
  final bool islike; // New field

  TrendingItem({
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
    required this.playlist_name,
    required this.islike, // Include in constructor
  });

  factory TrendingItem.fromJson(Map<String, dynamic> json) {
    return TrendingItem(
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
      playlist_name: json['playlist_name'] ?? '',
      islike: json['islike'] ?? false, // Parse the new field
    );
  }
}

class TrendingController extends GetxController {
  var trendingList = <TrendingItem>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchTrendingPlaylist();
    super.onInit();
  }

  Future<void> fetchTrendingPlaylist() async {
    final url =
        'https://customize.hkdigiverse.com/hrcodeexpert/api/trending-playlist';

    try {
      isLoading(true);

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields.addAll({
        'user_id': VarUtils.ID.toString(),
      });

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String jsonResponse = await response.stream.bytesToString();
        final data = jsonDecode(jsonResponse);

        if (data['status'] == 1) {
          trendingList.value = (data['data'] as List)
              .map((item) => TrendingItem.fromJson(item))
              .toList();
        } else {
          errorMessage.value = data['message'];
        }
      } else {
        errorMessage.value = 'Failed to load data: ${response.reasonPhrase}';
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
    } finally {
      isLoading(false);
    }
  }
}
