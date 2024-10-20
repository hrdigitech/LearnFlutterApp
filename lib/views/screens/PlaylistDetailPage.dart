import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/DetailPlaylistController.dart';
import '../routes/AppRoutes.dart';
import '../utils/ImageUtils.dart';
import '../utils/VarUtils.dart';

class PlaylistDetailPage extends StatelessWidget {
  PlaylistDetailPage({super.key});

  final DetailPlaylistController detailPlaylistController =
      Get.put(DetailPlaylistController());

  @override
  Widget build(BuildContext context) {
    final String playlistId = Get.arguments['id'].toString();
    log(playlistId);
    final String playlistTitle = Get.arguments['title'].toString();
    detailPlaylistController.fetchPlaylistDetails(playlistId);
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
                    ImageUtils.ImagePath + ImageUtils.PlaylistHeader,
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
                    playlistTitle, // Dynamic Playlist Title
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
                if (detailPlaylistController.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (detailPlaylistController
                    .playlistDetails.isNotEmpty) {
                  return buildPlaylistItems(h);
                } else {
                  return Center(child: Text("No playlist details available."));
                }
              }),
            ),
          ],
        ),
      ),
    );
  }

  // Build the playlist items
  Widget buildPlaylistItems(double h) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(h * 0.02),
        child: Column(
          children: detailPlaylistController.playlistDetails.map((item) {
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
                  child: SizedBox(
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
                            "https://customize.hkdigiverse.com/hrcodeexpert/storage/app/public//${item.image}",
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(width: h * 0.03),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title ?? '',
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
                                      Icon(Icons.calendar_today_outlined,
                                          color: Colors.grey, size: h * 0.018),
                                      SizedBox(width: h * 0.005),
                                      Text(item.date ?? '',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: h * 0.016)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.remove_red_eye_outlined,
                                          color: Colors.grey, size: h * 0.018),
                                      SizedBox(width: h * 0.005),
                                      Text(item.views.toString(),
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: h * 0.016)),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: h * 0.02),
                              Text(
                                "Description",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: h * 0.016,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: h * 0.0),
                              Text(
                                item.description ?? '',
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
    );
  }
}
