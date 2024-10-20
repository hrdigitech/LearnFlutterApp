import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:learn_flutter/views/utils/ImageUtils.dart';
import '../../controller/TrendingController.dart';
import '../routes/AppRoutes.dart';
import '../utils/VarUtils.dart';

class TrendingPage extends StatelessWidget {
  TrendingPage({super.key});

  final TrendingController trendingController = Get.put(TrendingController());

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: h * 0.2,
              width: double.infinity,
              padding: EdgeInsets.all(h * 0.01),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    ImageUtils.ImagePath + ImageUtils.TrendingHeader,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                      size: h * 0.04,
                    ),
                  ),
                  SizedBox(
                    height: h * 0.03,
                  ),
                  Text(
                    "Trending",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: h * 0.026,
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 8,
              child: Obx(() {
                // Use Obx to reactively listen to changes in trendingList
                if (trendingController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }

                if (trendingController.errorMessage.value.isNotEmpty) {
                  return Center(
                      child: Text(trendingController.errorMessage.value));
                }

                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(h * 0.02),
                    child: Column(
                      children: trendingController.trendingList.map((item) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.VIDEODETAILPAGE,
                                  arguments: {
                                    'videoId': item.id,
                                    'userId': VarUtils.ID.toString()
                                  },
                                );
                              },
                              child: Container(
                                height: h * 0.2,
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    Container(
                                      height: double.infinity,
                                      width: h * 0.2,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                          width: h * 0.01,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.25),
                                            offset: Offset(0, 0),
                                            blurRadius: 10,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: Image.network(
                                        "https://customize.hkdigiverse.com/hrcodeexpert/storage/app/public/${item.thumbnail}",
                                        fit: BoxFit.cover,
                                        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                          if (loadingProgress == null) return child; // Image loaded
                                          return Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress.expectedTotalBytes != null
                                                  ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                                                  : null,
                                            ),
                                          );
                                        },
                                        errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                          return Image.asset(
                                            ImageUtils.ImagePath + ImageUtils.DefaultImage,
                                            fit: BoxFit.cover,
                                          );
                                        },
                                      ),
                                    ),

                                    SizedBox(
                                      width: h * 0.03,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Title Text
                                          Text(
                                            item.title, // Change to item.title
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: h * 0.018,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: h * 0.02),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .calendar_today_outlined,
                                                    color: Colors.grey,
                                                    size: h * 0.018,
                                                  ),
                                                  SizedBox(width: h * 0.005),
                                                  Text(
                                                    DateFormat('dd-MM-yyyy')
                                                        .format(DateTime.parse(
                                                            item.createdAt)),
                                                    // Format date
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: h * 0.016,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              // Views Text
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .remove_red_eye_outlined,
                                                    color: Colors.grey,
                                                    size: h * 0.018,
                                                  ),
                                                  SizedBox(width: h * 0.005),
                                                  Text(
                                                    item.view.toString(),
                                                    // Change to item.view
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: h * 0.016,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: h * 0.02),
                                          Text(
                                            "Playlist",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: h * 0.016,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          SizedBox(height: h * 0.0),
                                          Text(
                                                  item.playlist_name,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: h * 0.016,
                                                  ),
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: h * 0.02),
                          ],
                        );
                      }).toList(),
                    ),
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
