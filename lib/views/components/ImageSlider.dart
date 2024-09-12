import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ImageSlider extends StatelessWidget {
  final List<Map<String, String>> sliderItems = [
    {
      'image':
      'https://www.daily.co/blog/content/images/2023/07/Flutter-feature.png',
      'title': 'First Image',
      'url': 'https://first-link.com'
    },
    {
      'image':
      'https://cdn.prod.website-files.com/654366841809b5be271c8358/659efd7c0732620f1ac6a1d6_why_flutter_is_the_future_of_app_development%20(1).webp',
      'title': 'Second Image',
      'url': 'https://second-link.com'
    },
    {
      'image':
      'https://www.mindinventory.com/blog/wp-content/uploads/2022/10/flutter-3.png',
      'title': 'Third Image',
      'url': 'https://third-link.com'
    },
  ];

  // Function to launch URL
  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return CarouselSlider.builder(
      itemCount: sliderItems.length,
      itemBuilder: (context, index, realIndex) {
        final sliderItem = sliderItems[index];
        return GestureDetector(
          onTap: () {
            _launchURL(sliderItem['url']!); // Handle the URL redirection
          },
          child: Container(
            height: h * 0.18,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: h * 0.01),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(h * 0.01),
              image: DecorationImage(
                image: NetworkImage(sliderItem['image']!),
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.all(h * 0.02),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                sliderItem['title']!,
                style: TextStyle(
                  fontSize: h * 0.02,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
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
  }
}
