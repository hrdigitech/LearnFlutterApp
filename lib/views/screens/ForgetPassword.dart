import 'package:flutter/material.dart';
import '../utils/LinearColorUtils.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

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
