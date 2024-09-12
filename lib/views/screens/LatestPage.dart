import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/views/utils/ImageUtils.dart';

class LatestPage extends StatelessWidget {
  LatestPage({super.key});

  final List<Map<String, String>> latestItems = [
    {
      'image':
      'https://miro.medium.com/v2/resize:fit:1000/1*GQ3zQ1uln6vVTGB_5VKKHg.jpeg',
      'title': 'David Austin, Who Breathed Life Into',
      'playlist': 'Discover the legacy',
      'date': '10/09/2024',
      'views': '100',
    },
    {
      'image':
      'https://miro.medium.com/v2/resize:fit:1000/1*GQ3zQ1uln6vVTGB_5VKKHg.jpeg',
      'title': 'Flutter - The Future of App Development',
      'playlist': 'Discover the legacy',
      'date': '10/09/2024',
      'views': '100',
    },
    {
      'image':
      'https://miro.medium.com/v2/resize:fit:1000/1*GQ3zQ1uln6vVTGB_5VKKHg.jpeg',
      'title': 'Learn Dart for Flutter Development',
      'playlist': 'Discover the legacy',
      'date': '10/09/2024',
      'views': '100',
    },
    {
      'image':
      'https://miro.medium.com/v2/resize:fit:1000/1*GQ3zQ1uln6vVTGB_5VKKHg.jpeg',
      'title': 'Building Complex UI with Flutter',
      'playlist': 'Discover the legacy',
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
                    ImageUtils.ImagePath + ImageUtils.LatestHeader,
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
                    "Latest",
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
                    children: latestItems.map((item) {
                      return Column(
                        children: [
                          Container(
                            height: h * 0.2,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Container(
                                  height: double.infinity,
                                  width: h * 0.2,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                      width: h * 0.01,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: Offset(0, 0),
                                        blurRadius: 10,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Image.network(
                                    item['image']!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: h * 0.03,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      // Title Text
                                      Text(
                                        item['title']!,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: h * 0.018,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: h * 0.02),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.calendar_today_outlined,
                                                color: Colors.grey,
                                                size: h * 0.018,
                                              ),
                                              SizedBox(width: h * 0.005),
                                              Text(
                                                item['date']!,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: h * 0.016,
                                                ),
                                              ),
                                            ],
                                          ),
                                          // Views Text
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.remove_red_eye_outlined,
                                                color: Colors.grey,
                                                size: h * 0.018,
                                              ),
                                              SizedBox(width: h * 0.005),
                                              Text(
                                                item['views']!,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: h * 0.016,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: h * 0.02),
                                      Text(
                                        "Playlist",
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: h * 0.016,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(height: h * 0.0),
                                      Text(
                                        item['playlist']!,
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: h * 0.016,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
