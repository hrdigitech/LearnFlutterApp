import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/controller/EditProfileController.dart';
import 'package:learn_flutter/views/components/BlackAuthField.dart';
import 'package:learn_flutter/views/utils/ImageUtils.dart';
import '../utils/LinearColorUtils.dart';
import '../utils/SVGUtils.dart';
import '../utils/VarUtils.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});

  final EditProfileController controller = Get.put(EditProfileController());

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
                        // Profile image section
                        Obx(() => GestureDetector(
                          onTap: () {
                            controller.pickImage();
                          },
                          child: Container(
                            height: h * 0.16,
                            width: h * 0.16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                              image: DecorationImage(
                                image: controller.selectedImage.value != null
                                    ? FileImage(controller.selectedImage.value!) // Show picked image
                                    : NetworkImage(
                                  VarUtils.ProfileImage.isEmpty
                                      ? "https://customize.brainartit.com/ecommerce/storage/app/public/user-image/Default.png"
                                      : VarUtils.ProfileImage,
                                ) as ImageProvider,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )),
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
                          svgIcon: SVGUtils.kCall,
                          validator: (value) => controller.validatePhoneNumber(value),
                        ),
                        SizedBox(height: h * 0.02),
                        BlackAuthField(
                          controller: controller.mailController,
                          hintText: "Enter Email",
                          label: "Email Address",
                          svgIcon: SVGUtils.kMail,
                          validator: (value) => controller.validateEmail(value),
                        ),
                        SizedBox(height: h * 0.04),
                        Obx(() => GestureDetector(
                          onTap: () {
                            if (!controller.isLoading.value) {
                              if (controller.formKey.currentState!.validate()) {
                                controller.onSaveOnTap();
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
                            alignment: Alignment.center,
                            child: Text(
                              controller.isLoading.value ? "Please wait..." : "Save",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: h * 0.02,
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
          ],
        ),
      ),
    );
  }
}
