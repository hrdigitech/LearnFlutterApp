import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/views/utils/VarUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/routes/AppRoutes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Load variables from SharedPreferences
  await loadVarUtilsData();

  runApp(
    const MyApp(),
  );
}

// Function to load data from SharedPreferences into VarUtils
Future<void> loadVarUtilsData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Load all required variables
  VarUtils.phoneNumber = prefs.getString('phoneNumber') ?? '';
  VarUtils.Name = prefs.getString('Name') ?? '';
  VarUtils.Email = prefs.getString('Email') ?? '';
  VarUtils.Password = prefs.getString('Password') ?? '';
  VarUtils.ProfileImage = prefs.getString('ProfileImage') ?? '';
  VarUtils.ID = prefs.getInt('ID') ?? 0;

  // Logging the data
  log("Loaded VarUtils data:");
  log("Phone Number: ${VarUtils.phoneNumber}");
  log("Name: ${VarUtils.Name}");
  log("Email: ${VarUtils.Email}");
  log("Password: ${VarUtils.Password}");
  log("Profile Image: ${VarUtils.ProfileImage}");
  log("ID: ${VarUtils.ID}");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.SPLASH,
      getPages: AppRoutes.routes,
    );
  }
}
