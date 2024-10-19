import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:learn_flutter/views/components/TitleText.dart';
import 'package:learn_flutter/views/utils/ImageUtils.dart';
import 'package:learn_flutter/views/utils/LinearColorUtils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../controller/VideoDetailController.dart';

class VideoDetailsPage extends StatefulWidget {
  VideoDetailsPage({super.key});

  @override
  State<VideoDetailsPage> createState() => _VideoDetailsPageState();
}

class _VideoDetailsPageState extends State<VideoDetailsPage> {
  final VideoDetailController controller = Get.put(VideoDetailController());
// @override
//   void initState() {
//     super.initState();
//     final id = Get.arguments;
//     print('id---->${id}');
//     if (id != null) {
//       controller.fetchVideoDetail(videoId: id);
//     } else {
//       Get.snackbar('Error', 'No video ID provided');
//     }
//   }
  @override
  Widget build(BuildContext context) {


    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Obx( (){
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (controller.videoDetailsModel?.data == null ||
              controller.videoDetailsModel!.data.title.isEmpty) {
            return const Center(
              child: Text("No results found"),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    const String videoUrl =
                        "https://www.youtube.com/watch?v=TTNdGjl0wqo";
                    if (await canLaunch(videoUrl)) {
                      await launch(videoUrl);
                    } else {
                      throw 'Could not launch $videoUrl';
                    }
                  },
                  child: Container(
                    height: h * 0.3,
                    width: double.infinity,
                    decoration:  BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          'https://customize.hkdigiverse.com/hrcodeexpert/storage/app/public/${controller.videoDetailsModel!.data.thumbnail}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: h * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: w * 0.02,
                    ),
                    Expanded(
                      child: Text(
                        controller.videoDetailsModel!.data.title,
                        // "Even on Urban Excursions,Finding Mother Nature's Charms",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: h * 0.02,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        height: h * 0.06,
                        width: w * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              h * 0.024,
                            ),
                            bottomLeft: Radius.circular(
                              h * 0.024,
                            ),
                          ),
                          gradient: LinearColorUtils.primaryGradient(),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(
                    h * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                DateFormat('dd/MM/yyyy').format(DateTime.parse(controller.videoDetailsModel!.data.createdAt.toString())),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: h * 0.016,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.grey,
                                size: h * 0.018,
                              ),
                              SizedBox(width: h * 0.005),
                              Text(
                                "100",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: h * 0.016,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.favorite_border,
                                color: Colors.grey,
                                size: h * 0.018,
                              ),
                              SizedBox(width: h * 0.005),
                              Text(
                                "100",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: h * 0.016,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.supervised_user_circle,
                                color: Colors.grey,
                                size: h * 0.018,
                              ),
                              SizedBox(width: h * 0.005),
                              Text(
                                "100",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: h * 0.016,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      TitleText(
                        text: "Description",
                        fontSize: h * 0.022,
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      Text(
                        controller.videoDetailsModel!.data.description,
                        // "Public parks aside, getting a dose of nature can be a tricky task during an urban escape. But nat ure should and can fit into that city getaway, according to Kally Ellis, the founder of the London fl orist company McQueens and the in-house florist for the Maybourne Hotel Group. “Connecting with the natural world wherever you are is a great antidote to jet lag and travel tiredness,” she said. “Plants and flowers can refresh us, boost our energy and help us recalibrate.",
                        style: TextStyle(
                            fontSize: h * 0.016,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      TitleText(
                        text: "Previews",
                        fontSize: h * 0.022,
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      SizedBox(
                        height: h * 0.4, // Set height for the row
                        child: Obx(() {
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.previewImages.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  log("Tapped on preview ${index + 1}");
                                },
                                child: Container(
                                  width: w * 0.46, // Maintain a 9:16 aspect ratio
                                  margin:
                                  EdgeInsets.symmetric(horizontal: w * 0.02),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          controller.previewImages[index]),
                                      fit: BoxFit.cover,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.25),
                                        offset: Offset(0, 4),
                                        blurRadius: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        }),
                      ),

                      SizedBox(
                        height: h * 0.02,
                      ),
                      TitleText(
                        text: "Previews",
                        fontSize: h * 0.022,
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async{
                              String github =
                                  controller.videoDetailsModel!.data.githubLink;
                              if (await canLaunch(github)) {
                                await launch(github);
                              } else {
                                throw 'Could not launch $github';
                              }
                            },
                            child: Container(
                              height: h * 0.04,
                              width: h * 0.04,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    ImageUtils.ImagePath + ImageUtils.Github,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: h * 0.014,
                          ),
                          GestureDetector(
                            onTap: () async{
                              String youTube =
                                  controller.videoDetailsModel!.data.youtubeLink;
                              if (await canLaunch(youTube)) {
                                await launch(youTube);
                              } else {
                                throw 'Could not launch $youTube';
                              }
                            },
                            child: Container(
                              height: h * 0.04,
                              width: h * 0.04,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    ImageUtils.ImagePath + ImageUtils.Youtube,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: h * 0.014,
                          ),
                          GestureDetector(
                            onTap: ()async {
                              String linkedin =
                                  controller.videoDetailsModel!.data.linkdinLink;
                              if (await canLaunch(linkedin)) {
                                await launch(linkedin);
                              } else {
                                throw 'Could not launch $linkedin';
                              }
                            },
                            child: Container(
                              height: h * 0.04,
                              width: h * 0.04,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    ImageUtils.ImagePath + ImageUtils.Linkdin,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      TitleText(
                        text: "Features",
                        fontSize: h * 0.022,
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      Text(
                        "Public parks aside, getting a dose of nature can be a tricky task during an urban escape. But nat ure should and can fit into that city getaway, according to Kally Ellis, the founder of the London fl orist company McQueens and the in-house florist for the Maybourne Hotel Group. “Connecting with the natural world wherever you are is a great antidote to jet lag and travel tiredness,” she said. “Plants and flowers can refresh us, boost our energy and help us recalibrate.",
                        style: TextStyle(
                            fontSize: h * 0.016,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        )
      ),
    );
  }
}
