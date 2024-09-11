import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/controller/EnterCodeController.dart';
import 'package:pin_input_text_field/pin_input_text_field.dart';

import '../routes/AppRoutes.dart';
import '../utils/LinearColorUtils.dart';

class EnterCodePage extends StatelessWidget {
  final EnterCodeController controller = Get.put(
    EnterCodeController(),
  );

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearColorUtils.primaryGradient(),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(
                h * 0.02,
              ),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(
                    h * 0.024,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: h * 0.1,
                      ),
                      Text(
                        "Enter Code",
                        style: TextStyle(
                          fontSize: h * 0.034,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "An Authentication Code Has Sent To test@gmail.com",
                        style: TextStyle(
                          fontSize: h * 0.024,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: h * 0.04),
                      PinInputTextField(
                        pinLength: 6,
                        controller: controller.pinEditingController,
                        autoFocus: true,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        decoration: UnderlineDecoration(
                          textStyle: TextStyle(color: Colors.white),
                          colorBuilder:
                              PinListenColorBuilder(Colors.white, Colors.white),
                        ),
                        onChanged: (pin) {
                          if (pin.length == 6) {
                            try {
                              log("Received OTP: $pin");
                            } catch (e) {
                              log("$e");
                            }
                          }
                        },
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "If you don’t receive code! ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: h * 0.016),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "Resent",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: h * 0.016,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                                decorationThickness: 2.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: h * 0.04),
                      GestureDetector(
                        onTap: () {
                          controller.onVerifyOnTap();
                        },
                        child: Container(
                          height: h * 0.06,
                          width: w,
                          decoration: BoxDecoration(
                            gradient: LinearColorUtils.secondGradient(),
                            borderRadius: BorderRadius.circular(
                              h * 0.01,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              "VERIFY",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: h * 0.024,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Back to ",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: h * 0.016),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.SIGNINSCREEN);
                            },
                            child: Text(
                              "SIGN IN?",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: h * 0.016,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
                                decorationThickness: 2.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
