import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/views/routes/AppRoutes.dart';

class CategoryBox extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final BoxShadow boxShadow;

  const CategoryBox({
    required this.title,
    required this.backgroundColor,
    required this.textColor,
    required this.boxShadow,
  });

  void _navigateToPage(String title) {
    switch (title) {
      case 'Playlist':
        Get.toNamed(AppRoutes.PLAYLISTPAGE);
        break;
      case 'Latest':
        Get.toNamed(AppRoutes.LATESTPAGE);
        break;
      case 'Trending':
        Get.toNamed(AppRoutes.TRENDINGPAGE);
        break;
      default:
        Get.snackbar("Oops...", "Page not found");
    }
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () => _navigateToPage(title),
      child: Container(
        height: h * 0.12,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(h * 0.01),
          boxShadow: [boxShadow],
        ),
        child: Center(
          child: Text(
            title,
            style: TextStyle(
              fontSize: h * 0.02,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
