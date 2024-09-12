import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:learn_flutter/views/components/TitleText.dart';
import 'package:learn_flutter/views/routes/AppRoutes.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../models/RateUs.dart';
import '../components/SettingComponents.dart';
import '../utils/ImageUtils.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final List<Map<String, dynamic>> accountSetting = [
    {
      'onTap': () {
        Get.toNamed(AppRoutes.EDITPROFILEPAGE);
      },
      'icon': Icons.person,
      'name': "Edit Profile",
    },
    {
      'onTap': () {
        Get.toNamed(AppRoutes.CHANGEPASSWORDPAGE);
      },
      'icon': Icons.lock,
      'name': "Change Password",
    },
  ];

  final List<Map<String, dynamic>> developer = [
    {
      'onTap': () {
        Share.share(
          '🌟 Check out this amazing app: 🌟\n\n'
              'Learn Flutter with ease and fun! 🚀\n\n'
              'Download it now from the Google Play Store: 📱\n'
              'https://play.google.com/store/apps/details?id=com.hrcodeexperts.learn_flutter\n\n'
              'Your feedback is greatly appreciated! 😊',
          subject: 'Check out this app!',
        );
      },
      'icon': Icons.share,
      'name': "Share App",
    },
    {
      'onTap': () async {
        const url = 'https://play.google.com/store/apps/dev?id=5361587938495506523';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      'icon': Icons.other_houses,
      'name': "Our Other Products",
    },
    {
      'onTap': () async {
        const url = 'https://www.hrdigitech.com';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
      },
      'icon': Icons.contact_page_outlined,
      'name': "Follow Us",
    },
    {
      'onTap': (BuildContext context) {
        RateUs().forceShowRateDialog(context);
      },
      'icon': Icons.star,
      'name': "Rate Us",
    },
    {
      'onTap': () {
        Get.toNamed(AppRoutes.PRIVACYPOLICY);
      },
      'icon': Icons.privacy_tip,
      'name': "Privacy Policy",
    },
    {
      'onTap': () {
        Get.toNamed(AppRoutes.ABOUTUSPAGE);
      },
      'icon': Icons.info_rounded,
      'name': "About Us",
    },
  ];

  final List<Map<String, dynamic>> settings = [
    {
      'onTap': () {
        Get.offAllNamed(AppRoutes.SIGNINSCREEN);
      },
      'icon': Icons.logout,
      'name': "Logout",
    },
    {
      'onTap': (BuildContext context) {
        showExitDialog(context);
      },
      'icon': Icons.exit_to_app,
      'name': "Exit",
    },
  ];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Profile Header Section
            Container(
              height: h * 0.3,
              width: double.infinity,
              padding: EdgeInsets.all(h * 0.01),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    ImageUtils.ImagePath + ImageUtils.ProfileHeader,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: h * 0.1,
                    width: h * 0.1,
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
                  Text(
                    "Admin",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: h * 0.026,
                    ),
                  ),
                  Text(
                    "admin@gmail.com",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: h * 0.022,
                    ),
                  ),
                ],
              ),
            ),
            // ListView for Account Settings, Developer, and Settings
            Flexible(
              flex: 8,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(h * 0.02),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Account Settings
                      TitleText(
                        text: "Account Setting",
                        fontSize: h * 0.024,
                      ),
                      SizedBox(height: h * 0.01),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: accountSetting.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(accountSetting[index]['icon']),
                            title: Text(accountSetting[index]['name']),
                            onTap: accountSetting[index]['onTap'] as void Function()?,
                            trailing: IconButton(
                              onPressed: accountSetting[index]['onTap'] as void Function()?,
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: h * 0.022,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: h * 0.02),
                      // Developer Section
                      TitleText(
                        text: "Developer",
                        fontSize: h * 0.024,
                      ),
                      SizedBox(height: h * 0.01),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: developer.length,
                        itemBuilder: (context, index) {
                          final onTap = developer[index]['onTap'];
                          return ListTile(
                            leading: Icon(developer[index]['icon']),
                            title: Text(developer[index]['name']),
                            onTap: () {
                              // Wrap the function to pass context if needed
                              if (onTap is Function(BuildContext)) {
                                onTap(context);
                              } else {
                                onTap();
                              }
                            },
                            trailing: IconButton(
                              onPressed: () {
                                // Wrap the function to pass context if needed
                                if (onTap is Function(BuildContext)) {
                                  onTap(context);
                                } else {
                                  onTap();
                                }
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: h * 0.022,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(height: h * 0.02),
                      // Settings Section
                      TitleText(
                        text: "Settings",
                        fontSize: h * 0.024,
                      ),
                      SizedBox(height: h * 0.01),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: settings.length,
                        itemBuilder: (context, index) {
                          final onTap = settings[index]['onTap'];
                          return ListTile(
                            leading: Icon(settings[index]['icon']),
                            title: Text(settings[index]['name']),
                            onTap: () {
                              // Wrap the function to pass context if needed
                              if (onTap is Function(BuildContext)) {
                                onTap(context);
                              } else {
                                onTap();
                              }
                            },
                            trailing: IconButton(
                              onPressed: () {
                                // Wrap the function to pass context if needed
                                if (onTap is Function(BuildContext)) {
                                  onTap(context);
                                } else {
                                  onTap();
                                }
                              },
                              icon: Icon(
                                Icons.arrow_forward_ios,
                                size: h * 0.022,
                              ),
                            ),
                          );
                        },
                      )
                    ],
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
