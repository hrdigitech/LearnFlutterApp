import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:learn_flutter/views/routes/AppRoutes.dart';
import 'package:learn_flutter/views/utils/ImageUtils.dart';
import '../../controller/LatestController.dart';
import '../utils/VarUtils.dart';

class LatestPage extends StatelessWidget {
  LatestPage({super.key});

  final LatestController _latestController = Get.put(LatestController());

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (_latestController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (_latestController.errorMessage.isNotEmpty) {
            return Center(child: Text(_latestController.errorMessage.value));
          }

          return Column(
            children: [
              // Header Section
              Container(
                height: h * 0.2,
                width: double.infinity,
                padding: EdgeInsets.all(h * 0.01),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                      ImageUtils.ImagePath + ImageUtils.LatestHeader,
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
                    SizedBox(height: h * 0.03),
                    Text(
                      "Latest",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: h * 0.026,
                      ),
                    ),
                  ],
                ),
              ),

              // Content Section
              Flexible(
                flex: 8,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(h * 0.02),
                    child: Column(
                      children: _latestController.latestList.map((item) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.VIDEODETAILPAGE,
                                  arguments: {
                                    'videoId': item.id,
                                    'userId': VarUtils.ID.toString(),
                                  },
                                );
                              },
                              child: Container(
                                height: h * 0.2,
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    // Thumbnail with CachedNetworkImage
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
                                      child: CachedNetworkImage(
                                        imageUrl:
                                        "https://customize.hkdigiverse.com/hrcodeexpert/storage/app/public/${item.thumbnail}",
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            Image.asset(
                                              ImageUtils.ImagePath +
                                                  ImageUtils.DefaultImage,
                                              fit: BoxFit.cover,
                                            ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                    SizedBox(width: h * 0.03),

                                    // Video Information
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.title,
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
                                              // Date
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
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: h * 0.016,
                                                    ),
                                                  ),
                                                ],
                                              ),

                                              // View Count
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

                                          // Playlist Information
                                          Text(
                                            "Playlist",
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: h * 0.016,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            item.playlist_name,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: h * 0.016,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
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
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
