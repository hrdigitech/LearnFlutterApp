import 'package:flutter/material.dart';
import 'package:learn_flutter/views/utils/ImageUtils.dart';
import 'package:learn_flutter/views/utils/LinearColorUtils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
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
                  // Aligning the text in the middle vertically
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // Centering vertically
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // Align text to the left
                    children: [
                      Text(
                        "Hello Dear",
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
                  // Aligning the image in the center
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
          ],
        ),
      ),
    );
  }
}
