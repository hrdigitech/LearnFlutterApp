import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/views/routes/AppRoutes.dart';

class ImageRowWidget extends StatelessWidget {
  // Dummy data
  final List<Map<String, String>> images = [
    {
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSFvYnevTpW6ZalCiz1grTyy2HmoU7kjeFcg&s',
      'title': 'Image One',
    },
    {
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSFvYnevTpW6ZalCiz1grTyy2HmoU7kjeFcg&s',
      'title': 'Image Two',
    },
    {
      'imageUrl': 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSSFvYnevTpW6ZalCiz1grTyy2HmoU7kjeFcg&s',
      'title': 'Image Three',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: images.map((imageData) {
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
                    image: NetworkImage(imageData['imageUrl']!),
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
