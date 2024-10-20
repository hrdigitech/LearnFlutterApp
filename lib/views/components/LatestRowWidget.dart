import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/LatestController.dart';
import '../routes/AppRoutes.dart';
import '../utils/VarUtils.dart';
import '../utils/ImageUtils.dart';  // Assuming ImageUtils has paths for default images

class LatestRowWidget extends StatelessWidget {
  final List<LatestItem> latestItems;

  LatestRowWidget({required this.latestItems});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    final List<LatestItem> displayedItems = latestItems.take(5).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: displayedItems.map((item) {
          return Padding(
            padding: EdgeInsets.only(right: w * 0.06),
            child: GestureDetector(
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
                height: h * 0.18,
                width: w * 0.76,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(h * 0.01),
                  color: Colors.black,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(h * 0.01),
                  child: CachedNetworkImage(
                    imageUrl: "https://customize.hkdigiverse.com/hrcodeexpert/storage/app/public/" + item.thumbnail,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Image.asset(
                      ImageUtils.ImagePath + ImageUtils.DefaultImage,  // Path for default image
                      fit: BoxFit.cover,
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
