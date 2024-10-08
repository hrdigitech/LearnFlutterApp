import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/views/utils/ImageUtils.dart';

import '../routes/AppRoutes.dart';

class WishlistPage extends StatelessWidget {
  WishlistPage({super.key});

  final List<Map<String, String>> playlistItems = [
    {
      'image':
      'https://miro.medium.com/v2/resize:fit:1000/1*GQ3zQ1uln6vVTGB_5VKKHg.jpeg',
      'title': 'David Austin, Who Breathed Life Into',
      'description':
      'Discover the legacy of David Austin and his impact on horticulture.',
      'date': '10/09/2024',
      'views': '100',
    },
    {
      'image':
      'https://miro.medium.com/v2/resize:fit:1000/1*GQ3zQ1uln6vVTGB_5VKKHg.jpeg',
      'title': 'Flutter - The Future of App Development',
      'description':
      'Explore why Flutter is the future of cross-platform mobile app development.',
      'date': '10/09/2024',
      'views': '100',
    },
    {
      'image':
      'https://miro.medium.com/v2/resize:fit:1000/1*GQ3zQ1uln6vVTGB_5VKKHg.jpeg',
      'title': 'Learn Dart for Flutter Development',
      'description': 'Master Dart, the programming language behind Flutter.',
      'date': '10/09/2024',
      'views': '100',
    },
    {
      'image':
      'https://miro.medium.com/v2/resize:fit:1000/1*GQ3zQ1uln6vVTGB_5VKKHg.jpeg',
      'title': 'Building Complex UI with Flutter',
      'description': 'Learn how to create advanced UI layouts using Flutter.',
      'date': '10/09/2024',
      'views': '100',
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
                    ImageUtils.ImagePath + ImageUtils.WishlistHeader,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Wishlist",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: h * 0.026,
                  ),
                ),
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
                              Get.toNamed(AppRoutes.VIDEODETAILPAGE);
                            },
                            child: Container(
                              height: h * 0.28,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(h * 0.01),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.25),
                                    offset: Offset(0, 0),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                  ),
                                ],
                                image: DecorationImage(
                                  image: NetworkImage(item['image']!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                  height: h * 0.08,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius.circular(h * 0.01),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: h * 0.01),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item['title']!,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: h * 0.02,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.favorite,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
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
