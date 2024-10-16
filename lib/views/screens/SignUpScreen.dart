import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/SignUpController.dart';
import '../components/AuthField.dart';
import '../routes/AppRoutes.dart';
import '../utils/ImageUtils.dart';
import '../utils/LinearColorUtils.dart';
import '../utils/SVGUtils.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final SignUpController controller = Get.put(
      SignUpController(),
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
              child: Obx(() {
                return SingleChildScrollView(
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
                        "Please Enter details to create an account",
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
                              ImageUtils.ImagePath + ImageUtils.SignUpVector,
                            ),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.04),
                      _buildTextFieldSection(
                        context,
                        "Name",
                        controller.usernameController,
                        SVGUtils.kUser,
                        controller.validateName,
                        'Enter Full Name',
                        controller.isLoading.value,
                      ),
                      SizedBox(height: h * 0.02),
                      _buildTextFieldSection(
                        context,
                        "Phone Number",
                        controller.contactController,
                        SVGUtils.kCall,
                        controller.validatePhoneNumber,
                        'Enter Contact Number',
                        controller.isLoading.value,
                      ),
                      SizedBox(height: h * 0.02),
                      _buildTextFieldSection(
                        context,
                        "Email Address",
                        controller.mailController,
                        SVGUtils.kMail,
                        controller.validateEmail,
                        'Email address',
                        controller.isLoading.value,
                      ),
                      SizedBox(height: h * 0.02),
                      _buildTextFieldSection(
                        context,
                        "Password",
                        controller.passwordController,
                        SVGUtils.kLock,
                        controller.validatePassword,
                        'Password',
                        controller.isLoading.value,
                      ),
                      SizedBox(height: h * 0.04),
                      controller.isLoading.value
                          ? CircularProgressIndicator()
                          : GestureDetector(
                              onTap: () => controller.onSignUpTap(),
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
                                    "SIGN UP",
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
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(AppRoutes.SIGNINSCREEN);
                          },
                          child: Text(
                            "Already have an account?",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: h * 0.016),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextFieldSection(
    BuildContext context,
    String label,
    TextEditingController controller,
    String icon,
    String? Function(String?) validator,
    String hintText,
    bool isLoading,
  ) {
    double h = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: h * 0.016,
          ),
        ),
        SizedBox(height: h * 0.01),
        AuthField(
          iconColor: Colors.white,
          controller: controller,
          icon: icon,
          validator: validator,
          hintText: hintText,
        ),
      ],
    );
  }
}
