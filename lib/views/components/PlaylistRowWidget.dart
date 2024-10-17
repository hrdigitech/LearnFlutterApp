import 'package:flutter/material.dart';
import '../../models/PlaylistItem.dart';

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
                // Implement navigation or action on tap
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
