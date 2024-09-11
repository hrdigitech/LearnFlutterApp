import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/BottomNavigationController.dart';
import 'HomePage.dart';
import 'ProfilePage.dart';
import 'WishlistPage.dart';

class BottomNavigationPage extends StatelessWidget {
  BottomNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.put(BottomNavController(), permanent: true);

    return Scaffold(
      body: Obx(() {
        return _pages[controller.currentIndex.value];
      }),
      bottomNavigationBar: Obx(() {
        return BottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: (index) => controller.changeIndex(index),
          selectedItemColor: Color(0xFF00B6AA),
          unselectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              backgroundColor: Color(0xFF0B1521),
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
              label: 'Favourites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        );
      }),
    );
  }
  final List<Widget> _pages = [
    HomePage(),
    WishlistPage(),
    ProfilePage(),
  ];
}