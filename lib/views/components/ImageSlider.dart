import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controller/PeopleAlsoViewController.dart';
import '../utils/ImageUtils.dart';

class ImageSlider extends StatelessWidget {
  final PeopleAlsoViewController controller = Get.put(PeopleAlsoViewController());

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;

    return Obx(() {
      if (controller.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }
      if (controller.errorMessage.isNotEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      }

      return CarouselSlider.builder(
        itemCount: controller.peopleAlsoViewList.length,
        itemBuilder: (context, index, realIndex) {
          final sliderItem = controller.peopleAlsoViewList[index];
          return GestureDetector(
            onTap: () {
              _launchURL(sliderItem.link);
            },
            child: Container(
              height: h * 0.18,
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: h * 0.01),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(h * 0.01),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(h * 0.01),
                child: CachedNetworkImage(
                  imageUrl: "https://customize.hkdigiverse.com/hrcodeexpert/storage/app/public/peopleview/" + sliderItem.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Image.asset(
                    ImageUtils.ImagePath + ImageUtils.DefaultImage,
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        options: CarouselOptions(
          autoPlay: true,
          aspectRatio: 2.0,
          enlargeCenterPage: true,
        ),
      );
    });
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
