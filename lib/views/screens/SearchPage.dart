import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/views/utils/ImageUtils.dart';
import '../../controller/SearchPageController.dart';
import '../routes/AppRoutes.dart';
import '../utils/VarUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchPageController controller = Get.put(
      SearchPageController(),
    );
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              // Search header
              Container(
                height: h * 0.2,
                width: double.infinity,
                padding: EdgeInsets.all(h * 0.01),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      ImageUtils.ImagePath + ImageUtils.SearchHeader,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Search",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: h * 0.026,
                    ),
                  ),
                ),
              ),
              SizedBox(height: h * 0.02),
              _buildSearchBox(controller, h),
              SizedBox(height: h * 0.02),
              (controller.playlistItems.isEmpty)
                  ? Container()
                  : _buildSearchResults(controller, h),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildSearchBox(SearchPageController controller, double h) {
    return Container(
      height: h * 0.06,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: h * 0.02),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: Offset(0, 0),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(h * 0.03),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: h * 0.02),
            child: Icon(
              Icons.search,
              color: Colors.black.withOpacity(0.6),
            ),
          ),
          Expanded(
            child: TextField(
              controller: controller.searchController,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                hintText: "Search Above Flutter",
                hintStyle: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: h * 0.02,
                  vertical: h * 0.012,
                ),
              ),
              style: TextStyle(
                color: Colors.black.withOpacity(0.8),
              ),
              cursorColor: Colors.black.withOpacity(0.6),
              onSubmitted: (value) {
                controller.search();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(SearchPageController controller, double h) {
    if (controller.isLoading.value) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (controller.playlistItems.isEmpty) {
      return Center(
        child: Text("No Video Found"),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: controller.playlistItems.length,
        itemBuilder: (context, index) {
          var item = controller.playlistItems[index];
          return GestureDetector(
            onTap: () {
              Get.toNamed(AppRoutes.VIDEODETAILPAGE, arguments: {
                'videoId': item.id,
                'userId': VarUtils.ID.toString(),
              });
            },
            child: Container(
              margin: EdgeInsets.all(h * 0.02),
              height: h * 0.28,
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
              ),
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(h * 0.01),
                    child: CachedNetworkImage(
                      imageUrl:
                          "https://customize.hkdigiverse.com/hrcodeexpert/storage/app/public/${item.thumbnail}",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      placeholder: (context, url) => Image.asset(
                        ImageUtils.ImagePath + ImageUtils.DefaultImage,
                        // Default placeholder image
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(h * 0.01),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: h * 0.01,
                        vertical: h * 0.01,
                      ),
                      child: Text(
                        item.title,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: h * 0.02,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
