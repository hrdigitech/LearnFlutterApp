import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/controller/NewPasswordController.dart';
import '../components/AuthField.dart';
import '../routes/AppRoutes.dart';
import '../utils/ImageUtils.dart';
import '../utils/LinearColorUtils.dart';
import '../utils/SVGUtils.dart';
import '../utils/VarUtils.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final NewPasswordController controller = Get.put(
      NewPasswordController(),
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
            padding: EdgeInsets.all(h * 0.02),
            child: Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Enter New Password",
                    style: TextStyle(
                      fontSize: h * 0.034,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Your new password must be different from the previous password",
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
                          ImageUtils.ImagePath + ImageUtils.NewPasswordVector,
                        ),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  SizedBox(height: h * 0.04),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
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
                    controller: controller.passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    icon: SVGUtils.kLock,
                    onChnaged: (value) {
                      VarUtils.Password = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (!controller.isPasswordStrong(value)) {
                        return 'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one digit.';
                      }
                      return null;
                    },
                    hintText: 'Password',
                  ),
                  SizedBox(height: h * 0.02),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Confirm Password",
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
                    controller: controller.confirmPasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    icon: SVGUtils.kLock,
                    onChnaged: (value) {},
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a password';
                      }
                      if (value != controller.passwordController.text) {
                        return 'Passwords do not match';
                      }
                      if (!controller.isPasswordStrong(value)) {
                        return 'Password must be at least 8 characters long and contain at least one uppercase letter, one lowercase letter, and one digit.';
                      }
                      return null;
                    },
                    hintText: 'Confirm Password',
                  ),
                  SizedBox(height: h * 0.04),
                  GestureDetector(
                    onTap: () {
                      controller.onContinueOnTap();
                    },
                    child: Container(
                      height: h * 0.06,
                      width: w,
                      decoration: BoxDecoration(
                        gradient: LinearColorUtils.secondGradient(),
                        borderRadius: BorderRadius.circular(h * 0.01),
                      ),
                      child: Center(
                        child: Text(
                          "CONTINUE",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Back to ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: h * 0.016,
                        ),
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
