import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/PlaylistItem.dart';
import '../routes/AppRoutes.dart';
import '../utils/ImageUtils.dart';

class PlaylistRowWidget extends StatelessWidget {
  final List<PlaylistItem> playlistItems;

  PlaylistRowWidget({required this.playlistItems});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: playlistItems.map((item) {
          return Padding(
            padding: EdgeInsets.only(right: w * 0.06),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.PLAYLISTDETAILPAGE, arguments: {
                  'id': item.id,
                  'title': item.name,
                });
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
                    imageUrl: "https://customize.hkdigiverse.com/hrcodeexpert/storage/app/public/playlist/video/" + item.image,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Image.asset(
                      ImageUtils.ImagePath + ImageUtils.DefaultImage,
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
