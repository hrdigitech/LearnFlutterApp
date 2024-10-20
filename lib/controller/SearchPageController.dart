import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/models/LatestPlayList_Model.dart';
import 'package:learn_flutter/models/search_model.dart';

import '../views/utils/VarUtils.dart';

class SearchPageController extends GetxController{
  TextEditingController searchController = TextEditingController();
  var isLoading = false.obs;
  var playlistItems = [].obs;
  var latestPlayListIsLoading = false.obs;
  var latestPlaylists = <LatestPlayListModel>[].obs;
  @override
  void onInit() {
    search();
    fetchLatestPlaylists();
    super.onInit();
  }

  SearchModel? _searchModel;
  SearchModel? get searchModel => _searchModel;
  set searchModel(SearchModel? value) {
    _searchModel = value;
    update();
  }

  LatestPlayListModel? _latestPlayListModel;
  LatestPlayListModel? get latestPlayListModel => _latestPlayListModel;
  set latestPlayListModel(LatestPlayListModel? value) {
    _latestPlayListModel = value;
    update();
  }

  Future<void> search() async {
    String query = searchController.text;

    if (query.isEmpty) {
      Get.snackbar("Error", "Search field cannot be empty.");
      return;
    }

    try {
      isLoading(true);
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://customize.hkdigiverse.com/hrcodeexpert/api/search'),
      );
      request.fields['name'] = query;
      request.fields['user_id'] = VarUtils.ID.toString();
      log('Request URL: ${request.url}');
      log('Request Fields: ${request.fields}');
      var response = await request.send();
      log('response.statusCode${response.statusCode}');

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);
        if(jsonResponse['status'] == 1){
          if (jsonResponse != null) {
            SearchModel data = SearchModel.fromJson(jsonResponse);
            searchModel = data;
            playlistItems.assignAll(data.data);
            Get.snackbar("Error", "No data received");
          } else {
            Get.snackbar("Error", "No data received");
          }
        } else {
          Get.snackbar('Oops...', jsonResponse['message']);
        }

      } else {
        Get.snackbar("Error", "Failed to fetch results");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchLatestPlaylists() async {
    try {
      latestPlayListIsLoading(true);
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://customize.hkdigiverse.com/hrcodeexpert/api/latest-playlist'),
      );
      request.fields['user_id'] = VarUtils.ID.toString();
      log('Request URL: ${request.url}');
      log('Request Fields: ${request.fields}');
      var response = await request.send();
      log('response.statusCode${response.statusCode}');

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);
        log('jsonResponse$jsonResponse');

        if(jsonResponse['status'] == 1){
          LatestPlayListModel data = LatestPlayListModel.fromJson(jsonResponse);
          latestPlayListModel = data;
          // var playlists = jsonResponse['data']; // Extract the playlist data
          // // LatestPlayListModel data = LatestPlayListModel.fromJson(jsonResponse);
          // latestPlaylists.assignAll(
          //     playlists.map((item) => LatestPlayListModel.fromJson(item)).toList()
          // );
          Get.snackbar('Success...', jsonResponse['message']);
        } else {
          Get.snackbar('Oops...', jsonResponse['message']);
        }

      } else {
        Get.snackbar("Error", "Failed to fetch playlists");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: ${e.toString()}");
    } finally {
      latestPlayListIsLoading(false);
    }
  }

}