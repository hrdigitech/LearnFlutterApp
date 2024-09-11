import 'package:flutter/material.dart';
import 'package:learn_flutter/views/utils/LinearColorUtils.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearColorUtils.primaryGradient(),
        ),
      ),
    );
  }
}
