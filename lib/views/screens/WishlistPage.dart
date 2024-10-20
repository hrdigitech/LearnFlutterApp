import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/views/utils/ImageUtils.dart';
import '../../controller/WishlistController.dart';
import '../routes/AppRoutes.dart';
import '../utils/VarUtils.dart';

class WishlistPage extends StatelessWidget {
  final WishlistController wishlistController = Get.put(WishlistController());

  WishlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    // Fetch the wishlist data when this page is built
    wishlistController.fetchWishlist();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Header section with Wishlist title
            Container(
              height: h * 0.2,
              width: double.infinity,
              padding: EdgeInsets.all(h * 0.01),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    ImageUtils.ImagePath + ImageUtils.WishlistHeader,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Wishlist",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: h * 0.026,
                  ),
                ),
              ),
            ),

            // Main content section
            Expanded(
              child: Obx(() {
                if (wishlistController.isLoading.value) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }

                if (wishlistController.wishlistItems.isEmpty) {
                  return Center(
                    child: Text(
                      'Your wishlist is empty!',
                      style: TextStyle(
                        fontSize: h * 0.022,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  );
                }
                return SingleChildScrollView(
                  padding: EdgeInsets.all(h * 0.02),
                  child: Column(
                    children: wishlistController.wishlistItems.map((item) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(
                                AppRoutes.VIDEODETAILPAGE,
                                arguments: {
                                  'videoId': item['id'],
                                  'userId': VarUtils.ID.toString()
                                },
                              );
                            },
                            child: Container(
                              height: h * 0.28,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(h * 0.01),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    offset: Offset(0, 0),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                                image: DecorationImage(
                                  image: NetworkImage(
                                      "https://customize.hkdigiverse.com/hrcodeexpert/storage/app/public/${item['thumbnail']}"),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  height: h * 0.08,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.circular(h * 0.01),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: h * 0.01),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item['title'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: h * 0.02,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          wishlistController
                                              .removeFromWishlist(item['id']);
                                        },
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: h * 0.02),
                        ],
                      );
                    }).toList(),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
