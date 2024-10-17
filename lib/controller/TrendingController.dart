import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// Model to represent each item in the trending playlist
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
  });

  factory TrendingItem.fromJson(Map<String, dynamic> json) {
    return TrendingItem(
      id: json['id'],
      thumbnail: json['thumbnail'],
      title: json['title'],
      view: json['view'],
      like: json['like'],
      comment: json['comment'],
      followers: json['followers'],
      description: json['description'],
      youtubeLink: json['youtube_link'],
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
    final url = 'https://customize.hkdigiverse.com/hrcodeexpert/api/trending-playlist';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

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
      isLoading.value = false;
    }
  }
}
