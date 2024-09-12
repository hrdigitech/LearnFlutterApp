import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/controller/EditProfileController.dart';
import 'package:learn_flutter/views/components/BlackAuthField.dart';
import 'package:learn_flutter/views/utils/ImageUtils.dart';
import '../utils/LinearColorUtils.dart';
import '../utils/SVGUtils.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});

  final EditProfileController controller = Get.put(
    EditProfileController(),
  );

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
                    ImageUtils.ImagePath + ImageUtils.EditProfileHeader,
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
                    "Edit Profile",
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
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        Container(
                          height: h * 0.16,
                          width: h * 0.16,
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
                        SizedBox(height: h * 0.02),
                        BlackAuthField(
                          controller: controller.usernameController,
                          hintText: "Enter Full Name",
                          label: "Name",
                          svgIcon: SVGUtils.kUser,
                          validator: (value) => controller.validateName(value),
                        ),
                        SizedBox(height: h * 0.02),
                        BlackAuthField(
                          controller: controller.contactController,
                          hintText: "Enter Contact Number",
                          label: "Contact Number",
                          svgIcon: SVGUtils.kLock,
                          validator: (value) =>
                              controller.validatePhoneNumber(value),
                        ),
                        SizedBox(height: h * 0.02),
                        BlackAuthField(
                          controller: controller.mailController,
                          hintText: "Enter Email",
                          label: "Email Address",
                          svgIcon: SVGUtils.kLock,
                          validator: (value) => controller.validateEmail(value),
                        ),
                        SizedBox(height: h * 0.04),
                        GestureDetector(
                          onTap: () {
                            if (controller.formKey.currentState!.validate()) {
                              controller.onSaveOnTap();
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
                              child: Text(
                                "SAVE",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: h * 0.024,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
