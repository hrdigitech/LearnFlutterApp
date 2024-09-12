import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:learn_flutter/views/components/TitleText.dart';

import '../components/SettingComponents.dart';
import '../utils/ImageUtils.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final List<Map<String, dynamic>> accountSetting = [
    {
      'onTap': () {},
      'icon': Icons.person,
      'name': "Edit Profile",
    },
    {
      'onTap': () {},
      'icon': Icons.lock,
      'name': "Change Password",
    },
  ];

  final List<Map<String, dynamic>> developer = [
    {
      'onTap': () {},
      'icon': Icons.share,
      'name': "Share App",
    },
    {
      'onTap': () {},
      'icon': Icons.other_houses,
      'name': "Our Other Products",
    },
    {
      'onTap': () {},
      'icon': Icons.contact_page_outlined,
      'name': "Follow Us",
    },
    {
      'onTap': () {},
      'icon': Icons.star,
      'name': "Rate Us",
    },
    {
      'onTap': () {},
      'icon': Icons.privacy_tip,
      'name': "Privacy Policy",
    },
    {
      'onTap': () {},
      'icon': Icons.info_rounded,
      'name': "About Us",
    },
  ];

  final List<Map<String, dynamic>> settings = [
    {
      'onTap': () {},
      'icon': Icons.logout,
      'name': "Logout",
    },
    {
      'onTap': (BuildContext context) => showExitDialog(context),
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
                    "Hello Dear",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: h * 0.026,
                    ),
                  ),
                  Text(
                    "Let’s Learn More About Flutter",
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
                            onTap: accountSetting[index]['onTap'],
                            trailing: IconButton(
                              onPressed: accountSetting[index]['onTap'],
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
                          return ListTile(
                            leading: Icon(developer[index]['icon']),
                            title: Text(developer[index]['name']),
                            onTap: developer[index]['onTap'],
                            trailing: IconButton(
                              onPressed: developer[index]['onTap'],
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
                          return ListTile(
                            leading: Icon(settings[index]['icon']),
                            title: Text(settings[index]['name']),
                            onTap: () => settings[index]['onTap'](context), // Pass the context here
                            trailing: IconButton(
                              onPressed: () => settings[index]['onTap'](context), // Pass the context
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
