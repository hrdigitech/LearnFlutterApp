import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/controller/SplashController.dart';
import 'package:learn_flutter/views/utils/ImageUtils.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              ImageUtils.ImagePath + ImageUtils.SplashScreen,
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
