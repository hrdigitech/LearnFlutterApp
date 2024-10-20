import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/PlaylistItem.dart';
import '../routes/AppRoutes.dart';
import '../utils/VarUtils.dart';

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

                },);
              },
              child: Container(
                height: h * 0.18,
                width: w * 0.76,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(h * 0.01),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://customize.hkdigiverse.com/hrcodeexpert/storage/app/public/playlist/video/" + item.image,
                    ),
                    fit: BoxFit.cover,
                  ),
                  color: Colors.black,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
