import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/PeopleAlsoViewItem.dart';

class PeopleAlsoViewController extends GetxController {
  var peopleAlsoViewList = <PeopleAlsoViewItem>[].obs;
  var isLoading = true.obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchPeopleAlsoView();
    super.onInit();
  }

  Future<void> fetchPeopleAlsoView() async {
    try {
      isLoading(true);
      var request = http.Request('GET', Uri.parse('https://customize.hkdigiverse.com/hrcodeexpert/api/people-also-view'));
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String jsonResponse = await response.stream.bytesToString();
        var data = json.decode(jsonResponse)['data'] as List;

        peopleAlsoViewList.value = data.map((item) => PeopleAlsoViewItem.fromJson(item)).toList();
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
