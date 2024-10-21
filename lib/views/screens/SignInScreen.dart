import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/views/utils/ImageUtils.dart';
import 'package:learn_flutter/views/utils/SVGUtils.dart';
import '../../controller/SignInController.dart';
import '../components/AuthField.dart';
import '../routes/AppRoutes.dart';
import '../utils/LinearColorUtils.dart';
import '../utils/VarUtils.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final SignInController controller = Get.put(SignInController());

    return Scaffold(
      body: Obx(
        () => Container(
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
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Learn Flutter",
                        style: TextStyle(
                          fontSize: h * 0.034,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Welcome Back, try to SIGN IN",
                        style: TextStyle(
                          fontSize: h * 0.024,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: h * 0.04),
                      Container(
                        height: h * 0.26,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              ImageUtils.ImagePath + ImageUtils.SignInVector,
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
                      SizedBox(height: h * 0.02),

                      // Password Field
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
                      PassField(
                        iconColor: Colors.white,
                        controller: controller.passwordController,
                        keyboardType: TextInputType.visiblePassword,
                        icon: SVGUtils.kLock,
                        onChnaged: (value) {
                          VarUtils.Password = value!;
                          return null;
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
                      SizedBox(height: h * 0.01),

                      // Forget Password
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.FORGETPASSWORD);
                          },
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: h * 0.016),
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.04),

                      // Sign In Button with Loader
                      GestureDetector(
                        onTap: () => controller.onSignInTap(),
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
                            child: controller.isLoading.value
                                ? CircularProgressIndicator(
                                    color: Colors.black,
                                  )
                                : Text(
                                    "SIGN IN",
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Create an account",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: h * 0.016,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.toNamed(AppRoutes.SIGNUPSCREEN);
                            },
                            child: Text(
                              "SIGN UP?",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: h * 0.016,
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
