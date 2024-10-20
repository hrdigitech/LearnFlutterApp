import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/views/utils/VarUtils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/VideoDetailController.dart';
import '../../views/components/TitleText.dart';
import '../../views/utils/LinearColorUtils.dart';
import '../utils/ImageUtils.dart';
import 'package:cached_network_image/cached_network_image.dart';

class VideoDetailsPage extends StatelessWidget {
  VideoDetailsPage({super.key});

  final VideoDetailController controller = Get.put(
    VideoDetailController(),
  );

  @override
  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final videoDetail = controller.videoDetail;
          if (videoDetail.isEmpty) {
            return const Center(
              child: Text('No video details available.'),
            );
          }

          String thumbnailUrl =
              'https://customize.hkdigiverse.com/hrcodeexpert/storage/app/public/${videoDetail["thumbnail"]}';
          String youtubeUrl = videoDetail['youtube_link'] ?? '';

          return SingleChildScrollView(
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    if (await canLaunch(youtubeUrl)) {
                      await launch(youtubeUrl);
                    } else {
                      throw 'Could not launch $youtubeUrl';
                    }
                  },
                  child: Container(
                    height: h * 0.3,
                    width: double.infinity,
                    decoration: BoxDecoration(),
                    child: CachedNetworkImage(
                      imageUrl: thumbnailUrl,
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                ImageUtils.ImagePath + ImageUtils.DefaultImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                                ImageUtils.ImagePath + ImageUtils.DefaultImage),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: h * 0.01),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: w * 0.02),
                    Expanded(
                      child: Text(
                        videoDetail['title'] ?? 'No Title',
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
                      onTap: () {
                        controller.toggleLike(VarUtils.ID.toString(), videoDetail['id'].toString());
                      },
                      child: Container(
                        height: h * 0.06,
                        width: w * 0.2,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(h * 0.024),
                            bottomLeft: Radius.circular(h * 0.024),
                          ),
                          gradient: LinearColorUtils.primaryGradient(),
                        ),
                        child: Center(
                          child: Icon(
                            controller.isLike.value
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(h * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Video Stats
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildInfoRow(
                            context,
                            Icons.remove_red_eye_outlined,
                            "${videoDetail['view']}",
                          ),
                          _buildInfoRow(
                            context,
                            Icons.favorite_border,
                            "${videoDetail['like']}",
                          ),
                          _buildInfoRow(
                            context,
                            Icons.supervised_user_circle,
                            "${videoDetail['followers']}",
                          ),
                        ],
                      ),
                      SizedBox(height: h * 0.02),
                      // Description
                      videoDetail['description'] == null
                          ? Container()
                          : TitleText(text: "Description", fontSize: h * 0.022),
                      videoDetail['description'] == null
                          ? Container()
                          : SizedBox(height: h * 0.01),
                      videoDetail['description'] == null
                          ? Container()
                          : Text(
                              videoDetail['description'] ??
                                  'No description available.',
                              style: TextStyle(
                                fontSize: h * 0.016,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                      SizedBox(height: h * 0.02),
                      // Previews
                      videoDetail['preview_img'] == ''
                          ? Container()
                          : TitleText(text: "Previews", fontSize: h * 0.022),
                      videoDetail['preview_img'] == ''
                          ? Container()
                          : SizedBox(height: h * 0.01),
                      videoDetail['preview_img'] == ''
                          ? Container()
                          : SizedBox(
                              height: h * 0.4,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.previewImages.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      log("Tapped on preview ${index + 1}");
                                    },
                                    child: Container(
                                      width: w * 0.46,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: w * 0.02),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.25),
                                            offset: Offset(0, 4),
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              controller.previewImages[index],
                                          placeholder: (context, url) =>
                                              Image.asset(
                                            ImageUtils.ImagePath +
                                                ImageUtils.DefaultImage,
                                            fit: BoxFit.cover,
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Image.asset(
                                            ImageUtils.ImagePath +
                                                ImageUtils.DefaultImage,
                                            fit: BoxFit.cover,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),

                      SizedBox(height: h * 0.02),
                      TitleText(
                        text: "Links",
                        fontSize: h * 0.022,
                      ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      Row(
                        children: [
                          videoDetail['github_link'] == null
                              ? Container()
                              : GestureDetector(
                                  onTap: () async {
                                    final String? githubUrl = videoDetail[''];
                                    if (githubUrl != null &&
                                        await canLaunch(githubUrl)) {
                                      await launch(githubUrl);
                                    } else {
                                      throw 'Could not launch $githubUrl';
                                    }
                                  },
                                  child: Container(
                                    height: h * 0.04,
                                    width: h * 0.04,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          ImageUtils.ImagePath +
                                              ImageUtils.Github,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                          videoDetail['youtube_link'] == null
                              ? Container()
                              : SizedBox(
                                  width: h * 0.014,
                                ),
                          videoDetail['youtube_link'] == null
                              ? Container()
                              : GestureDetector(
                                  onTap: () async {
                                    final String? youtubeUrl =
                                        videoDetail['youtube_link'];
                                    if (youtubeUrl != null &&
                                        await canLaunch(youtubeUrl)) {
                                      await launch(youtubeUrl);
                                    } else {
                                      throw 'Could not launch $youtubeUrl';
                                    }
                                  },
                                  child: Container(
                                    height: h * 0.04,
                                    width: h * 0.04,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          ImageUtils.ImagePath +
                                              ImageUtils.Youtube,
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                          videoDetail['linkdin_link'] == null
                              ? Container()
                              : SizedBox(
                                  width: h * 0.014,
                                ),
                          videoDetail['linkdin_link'] == null
                              ? Container()
                              : GestureDetector(
                                  onTap: () async {
                                    String? linkedinUrl =
                                        videoDetail['linkdin_link'];
                                    if (linkedinUrl != null) {
                                      if (!linkedinUrl.startsWith('http')) {
                                        linkedinUrl = 'https://$linkedinUrl';
                                      }
                                      if (await canLaunch(linkedinUrl)) {
                                        await launch(linkedinUrl);
                                      } else {
                                        throw 'Could not launch $linkedinUrl';
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: h * 0.04,
                                    width: h * 0.04,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          ImageUtils.ImagePath +
                                              ImageUtils.Linkdin,
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
                      videoDetail['features'] == null
                          ? Container()
                          : TitleText(
                              text: "Features",
                              fontSize: h * 0.022,
                            ),
                      SizedBox(
                        height: h * 0.01,
                      ),
                      videoDetail['features'] == null
                          ? Container()
                          : Text(
                              videoDetail['features'] ??
                                  'No description available.',
                              style: TextStyle(
                                fontSize: h * 0.016,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, IconData icon, String text) {
    double h = MediaQuery.of(context).size.height;
    return Row(
      children: [
        Icon(icon, color: Colors.grey, size: h * 0.018),
        SizedBox(width: h * 0.005),
        Text(
          text,
          style: TextStyle(color: Colors.black, fontSize: h * 0.016),
        ),
      ],
    );
  }
}
