import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:learn_flutter/views/routes/AppRoutes.dart';
import 'package:learn_flutter/views/utils/ImageUtils.dart';
import '../../controller/PlaylistController.dart';

class PlaylistPage extends StatelessWidget {
  PlaylistPage({super.key});

  final PlaylistController controller = Get.put(PlaylistController());

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
                    "Playlist",
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
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                }
                if (controller.errorMessage.isNotEmpty) {
                  return Center(child: Text(controller.errorMessage.value));
                }

                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(h * 0.02),
                    child: Column(
                      children: controller.playlist.map((item) {
                        return Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(
                                  AppRoutes.PLAYLISTDETAILPAGE,
                                  arguments: {
                                    'id': item.id,
                                    'title': item.name,
                                  },
                                );
                              },
                              child: Container(
                                height: h * 0.24,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(h * 0.01),
                                ),
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(h * 0.01),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "https://customize.hkdigiverse.com/hrcodeexpert/storage/app/public/playlist/video/${item.image}",
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: double.infinity,
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
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Container(
                                        height: h * 0.05,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(h * 0.01),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: h * 0.01),
                                        child: Center(
                                          child: Text(
                                            item.name,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: h * 0.02,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ),
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
