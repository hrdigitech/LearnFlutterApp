import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/LatestController.dart';
import '../routes/AppRoutes.dart';

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
                Get.toNamed(AppRoutes.VIDEODETAILPAGE, arguments: item);
              },
              child: Container(
                height: h * 0.18,
                width: w * 0.76,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(h * 0.01),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://customize.hkdigiverse.com/hrcodeexpert/storage/app/public/" + item.thumbnail,
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
