import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/controller/ForgetPasswordController.dart';
import '../components/AuthField.dart';
import '../routes/AppRoutes.dart';
import '../utils/ImageUtils.dart';
import '../utils/LinearColorUtils.dart';
import '../utils/SVGUtils.dart';
import '../utils/VarUtils.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final ForgetPasswordController controller = Get.put(
      ForgetPasswordController(),
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Forget Password",
                    style: TextStyle(
                      fontSize: h * 0.034,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Enter the email Associated with your account  and we’ll send and email to reset your Password",
                    style: TextStyle(
                      fontSize: h * 0.024,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: h * 0.04),
                  Container(
                    height: h * 0.26,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          ImageUtils.ImagePath +
                              ImageUtils.ForgetPasswordVector,
                        ),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.04),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email Address",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: h * 0.016,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.01),
                  AuthField(
                    iconColor: Colors.white,
                    controller: controller.mailController,
                    keyboardType: TextInputType.emailAddress,
                    icon: SVGUtils.kMail,
                    onChnaged: (value) {
                      VarUtils.Email = value!;
                      return null;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email address';
                      } else if (!GetUtils.isEmail(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                    hintText: 'Email address',
                  ),
                  SizedBox(height: h * 0.04),

                  // Sign In Button
                  GestureDetector(
                    onTap: () {
                      controller.onForgetPasswordOnTap();
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
                          "FORGET PASSWORD",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: h * 0.024,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.02),

                  // Sign Up Prompt
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
    );
  }
}
