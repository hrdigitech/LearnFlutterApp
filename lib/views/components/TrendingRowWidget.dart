import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/TrendingController.dart';
import '../routes/AppRoutes.dart';

class TrendingRowWidget extends StatelessWidget {
  final List<TrendingItem> trendingItems;

  TrendingRowWidget({required this.trendingItems});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    final List<TrendingItem> displayedItems = trendingItems.take(5).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: displayedItems.map((item) {
          return Padding(
            padding: EdgeInsets.only(right: w * 0.06),
            child: GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.VIDEODETAILPAGE);
              },
              child: Container(
                height: h * 0.18,
                width: w * 0.76,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(h * 0.01),
                  image: DecorationImage(
                    image: NetworkImage(
                      "https://customize.hkdigiverse.com/hrcodeexpert/storage/app/public/" +
                          item.thumbnail,
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

