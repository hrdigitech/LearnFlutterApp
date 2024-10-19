import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../views/utils/VarUtils.dart';

class WishlistController extends GetxController {
  var wishlistItems = [].obs;
  var isLoading = false.obs;

  Future<void> fetchWishlist() async {
    isLoading(true);
    try {
      var request = http.MultipartRequest('POST', Uri.parse('https://customize.hkdigiverse.com/hrcodeexpert/api/wishlist'));
      request.fields.addAll({'user_id': VarUtils.ID.toString()});

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var data = json.decode(responseBody);

        if (data['data'] != null && data['data'] is List && data['data'].isNotEmpty) {
          wishlistItems.assignAll(data['data']);
        } else {
          wishlistItems.clear();
        }
      } else {
        log("Error in fetching wishlist. Status code: ${response.statusCode}");
        wishlistItems.clear();
      }
    } catch (e) {
      log("Exception during wishlist fetch: $e");
      wishlistItems.clear();
    } finally {
      isLoading(false);
    }
  }

  Future<void> removeFromWishlist(int videoId) async {

    var request = http.MultipartRequest('POST', Uri.parse('https://customize.hkdigiverse.com/hrcodeexpert/api/remove-wishlist'));
    request.fields.addAll({
      'user_id': VarUtils.ID.toString(),
      'video_id': videoId.toString(),
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var data = json.decode(responseBody);


      if (data['status'] == 1) {
        wishlistItems.removeWhere((item) => item['id'] == videoId); // Remove from local list
        Get.snackbar('Success', data['message'], snackPosition: SnackPosition.BOTTOM);
      } else {
        log("Failed to remove item. Server message: ${data['message']}");
        Get.snackbar('Oops...', data['message'], snackPosition: SnackPosition.BOTTOM);
      }
    } else {
      log("Error in removing item from wishlist. Status code: ${response.statusCode}");
      Get.snackbar('Oops...', 'Something went wrong!', snackPosition: SnackPosition.BOTTOM);
    }
  }
}
