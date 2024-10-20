import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/controller/ChangePasswordController.dart';
import 'package:learn_flutter/views/components/BlackAuthField.dart';
import 'package:learn_flutter/views/utils/ImageUtils.dart';
import '../utils/LinearColorUtils.dart';
import '../utils/SVGUtils.dart';

class ChangePasswordPage extends StatelessWidget {
  ChangePasswordPage({super.key});

  final ChangePasswordController controller =
  Get.put(ChangePasswordController());

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                    ImageUtils.ImagePath + ImageUtils.ChangePasswordHeader,
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
                      Navigator.pop(context);
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
                    "Change Password",
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
                  child: FocusScope( // Wrap the Form with FocusScope
                    child: Form(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          BlackAuthField(
                            controller: controller.oldPasswordController,
                            hintText: "Enter Old Password",
                            label: "Old Password",
                            svgIcon: SVGUtils.kLock,
                            validator: controller.validatePassword,
                          ),
                          SizedBox(height: h * 0.02),
                          BlackAuthField(
                            controller: controller.passwordController,
                            hintText: "Enter New Password",
                            label: "New Password",
                            svgIcon: SVGUtils.kLock,
                            validator: controller.validatePassword,
                          ),
                          SizedBox(height: h * 0.02),
                          BlackAuthField(
                            controller: controller.confirmPasswordController,
                            hintText: "Confirm New Password",
                            label: "Confirm Password",
                            svgIcon: SVGUtils.kLock,
                            validator: controller.validateConfirmPassword,
                          ),
                          SizedBox(height: h * 0.04),
                          Obx(() => GestureDetector(
                            onTap: () {
                              if (!controller.isLoading.value) {
                                if (controller.formKey.currentState!.validate()) {
                                  controller.onChangePasswordOnTap();
                                }
                              }
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
                                child: controller.isLoading.value
                                    ? CircularProgressIndicator(color: Colors.black)
                                    : Text(
                                  "SAVE",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: h * 0.024,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
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
