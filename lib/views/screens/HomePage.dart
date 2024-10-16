import 'package:flutter/material.dart';
import 'package:learn_flutter/views/components/ImageRowWidget.dart';
import 'package:learn_flutter/views/components/ImageSlider.dart';
import 'package:learn_flutter/views/utils/ColorUtils.dart';
import 'package:learn_flutter/views/utils/ImageUtils.dart';
import 'package:learn_flutter/views/utils/VarUtils.dart';
import '../components/CategoryBox.dart';
import '../components/TitleText.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                    ImageUtils.ImagePath + ImageUtils.HomeHeader,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello ${VarUtils.Name}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: h * 0.026,
                        ),
                      ),
                      Text(
                        "Let’s Learn More About Flutter",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: h * 0.022,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: h * 0.06,
                    width: h * 0.06,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.black,
                      image: DecorationImage(
                        image: AssetImage(
                          ImageUtils.ImagePath + ImageUtils.SignUpVector,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 8,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(
                    h * 0.02,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CategoryBox(
                              title: "Playlist",
                              backgroundColor: ColorUtils.primaryColor,
                              textColor: Colors.white,
                              boxShadow: BoxShadow(
                                color: Colors.green.withOpacity(0.25),
                                offset: Offset(0, 0),
                                blurRadius: 14,
                                spreadRadius: 2,
                              ),
                            ),
                          ),
                          SizedBox(width: h * 0.02),
                          Expanded(
                            child: CategoryBox(
                              title: "Latest",
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              boxShadow: BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                offset: Offset(0, 0),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ),
                          ),
                          SizedBox(width: h * 0.02),
                          Expanded(
                            child: CategoryBox(
                              title: "Trending",
                              backgroundColor: Colors.white,
                              textColor: Colors.black,
                              boxShadow: BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                offset: Offset(0, 0),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      TitleText(
                        text: "People Also View",
                        fontSize: h * 0.024,
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      ImageSlider(),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      TitleText(
                        text: "Playlist",
                        fontSize: h * 0.024,
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      ImageRowWidget(),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      TitleText(
                        text: "Latest",
                        fontSize: h * 0.024,
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      ImageRowWidget(),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      TitleText(
                        text: "Trending",
                        fontSize: h * 0.024,
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      ImageRowWidget(),
                      SizedBox(
                        height: h * 0.02,
                      ),
                    ],
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
