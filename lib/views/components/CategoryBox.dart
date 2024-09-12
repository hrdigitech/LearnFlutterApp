import 'package:flutter/material.dart';

class CategoryBox extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Color textColor;
  final BoxShadow boxShadow;

  const CategoryBox({
    required this.title,
    required this.backgroundColor,
    required this.textColor,
    required this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Container(
      height: h * 0.12,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(h * 0.01),
        boxShadow: [boxShadow],
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            fontSize: h * 0.02,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
