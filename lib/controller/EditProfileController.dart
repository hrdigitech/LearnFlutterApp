import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import '../views/utils/VarUtils.dart';

class EditProfileController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController mailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  var isLoading = false.obs;

  Rx<File?> selectedImage = Rx<File?>(null);
  String initialName = '';
  String initialEmail = '';
  String initialPhone = '';

  @override
  void onInit() {
    super.onInit();
    // Auto-set values from VarUtils
    usernameController.text = VarUtils.Name;
    mailController.text = VarUtils.Email;
    contactController.text = VarUtils.phoneNumber;
    initialName = VarUtils.Name;
    initialEmail = VarUtils.Email;
    initialPhone = VarUtils.phoneNumber;
  }

  // Image picker method
  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery); // Pick image from gallery
    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  // Validator methods for each field
  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email address';
    } else if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (!GetUtils.isPhoneNumber(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  // Function to check if any data has changed
  bool hasChanges() {
    return usernameController.text != initialName ||
        mailController.text != initialEmail ||
        contactController.text != initialPhone ||
        selectedImage.value != null;
  }

  // Function to handle saving and updating the profile
  Future<void> onSaveOnTap() async {
    if (formKey.currentState!.validate()) {
      // Check if any values have changed
      if (!hasChanges()) {
        Get.snackbar('No Changes', 'Update the value first.');
        return;
      }

      isLoading.value = true;

      try {
        var request = http.MultipartRequest('POST', Uri.parse('https://customize.hkdigiverse.com/hrcodeexpert/api/update-Profile'));
        request.fields['phone'] = contactController.text;
        request.fields['username'] = usernameController.text;
        request.fields['email'] = mailController.text;
        request.fields['id'] = VarUtils.ID.toString();
        if (selectedImage.value != null) {
          request.files.add(await http.MultipartFile.fromPath('profile_image', selectedImage.value!.path));
        }
        http.StreamedResponse response = await request.send();
        if (response.statusCode == 200) {
          var responseData = await response.stream.bytesToString();
          var jsonData = jsonDecode(responseData);

          if (jsonData['status'] == 1) {
            VarUtils.Name = jsonData['data']['username'];
            VarUtils.Email = jsonData['data']['email'];
            VarUtils.phoneNumber = jsonData['data']['phone'].toString();
            VarUtils.ProfileImage = jsonData['data']['profile_image'];

            Get.snackbar('Success', 'Profile updated successfully!');
          } else {
            Get.snackbar('Oops...', jsonData['message']);
          }
        } else {
          Get.snackbar('Oops...', response.reasonPhrase ?? 'Something went wrong');
        }
      } catch (e) {
        Get.snackbar('Oops...', 'Failed to update profile: $e');
      } finally {
        isLoading.value = false;
      }
    }
  }

  @override
  void onClose() {
    mailController.dispose();
    contactController.dispose();
    usernameController.dispose();
    super.onClose();
  }
}
