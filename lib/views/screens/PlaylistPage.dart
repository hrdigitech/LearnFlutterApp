import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/views/routes/AppRoutes.dart';
import 'package:learn_flutter/views/utils/ImageUtils.dart';

class PlaylistPage extends StatelessWidget {
  PlaylistPage({super.key});

  final List<Map<String, String>> playlistItems = [
    {
      'image': 'https://miro.medium.com/v2/resize:fit:1000/1*GQ3zQ1uln6vVTGB_5VKKHg.jpeg',
      'title': 'David Austin, Who Breathed Life Into'
    },
    {
      'image': 'https://miro.medium.com/v2/resize:fit:1000/1*GQ3zQ1uln6vVTGB_5VKKHg.jpeg',
      'title': 'Flutter - The Future of App Development'
    },
    {
      'image': 'https://miro.medium.com/v2/resize:fit:1000/1*GQ3zQ1uln6vVTGB_5VKKHg.jpeg',
      'title': 'Learn Dart for Flutter Development'
    },
    {
      'image': 'https://miro.medium.com/v2/resize:fit:1000/1*GQ3zQ1uln6vVTGB_5VKKHg.jpeg',
      'title': 'Building Complex UI with Flutter'
    },
  ];

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
                      Get.back();
                    },
                    child: Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                      size: h * 0.04,
                    ),
                  ),
                  SizedBox(
                    height: h * 0.03,
                  ),
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
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(h * 0.02),
                  child: Column(
                    children: playlistItems.map((item) {
                      return Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.PLAYLISTDETAILPAGE);
                            },
                            child: Container(
                              height: h * 0.24,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(h * 0.01),
                                image: DecorationImage(
                                  image: NetworkImage(item['image']!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  height: h * 0.05,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(h * 0.01),
                                  ),
                                  padding: EdgeInsets.symmetric(horizontal: h * 0.01),
                                  child: Center(
                                    child: Text(
                                      item['title']!,
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
        ),
      ),
    );
  }
}
