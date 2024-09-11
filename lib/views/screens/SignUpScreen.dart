import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/controller/SignUpController.dart';
import '../components/AuthField.dart';
import '../routes/AppRoutes.dart';
import '../utils/ImageUtils.dart';
import '../utils/LinearColorUtils.dart';
import '../utils/SVGUtils.dart';
import '../utils/VarUtils.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    final SignUpController controller = Get.put(SignUpController());

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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Name",
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
                      controller: controller.usernameController,
                      keyboardType: TextInputType.name,
                      icon: SVGUtils.kUser,
                      onChnaged: (value) {
                        VarUtils.Name = value!;
                        return null;
                      },
                      validator: controller.validateName,
                      hintText: 'Enter Full Name',
                    ),
                    SizedBox(height: h * 0.02),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Phone Number",
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
                      controller: controller.contactController,
                      icon: SVGUtils.kCall,
                      onChnaged: (value) {
                        VarUtils.phoneNumber = value!;
                        return null;
                      },
                      validator: controller.validatePhoneNumber,
                      hintText: 'Enter Contact Number',
                    ),
                    SizedBox(height: h * 0.02),
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
                      validator: controller.validateEmail,
                      hintText: 'Email address',
                    ),
                    SizedBox(height: h * 0.02),
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
                        return null;
                      },
                      validator: controller.validatePassword,
                      hintText: 'Password',
                    ),
                    SizedBox(height: h * 0.04),
                    GestureDetector(
                      onTap: () {
                        controller.onSignUpTap();
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Already have an account?",
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
                                fontSize: h * 0.016),
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
    );
  }
}
