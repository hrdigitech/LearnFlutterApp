import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/controller/AboutUsController.dart';
import 'package:learn_flutter/views/utils/ImageUtils.dart';
import '../../controller/PrivacyPolicyController.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

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
                    ImageUtils.ImagePath + ImageUtils.PrivacyPolicyHeader,
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
                    "About Us",
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
                  child: GetX<AboutUsController>(
                    init: AboutUsController(),
                    builder: (controller) {
                      if (controller.htmlContent.isEmpty) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      } else if (controller.htmlContent.value
                          .startsWith('Error:')) {
                        return Center(
                          child: Text(
                            controller.htmlContent.value,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        );
                      } else {
                        return SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(h * 0.016),
                            child: HtmlWidget(
                              controller.htmlContent.value,
                              textStyle: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      }
                    },
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
