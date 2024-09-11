import 'package:flutter/material.dart';
import '../utils/LinearColorUtils.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

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
