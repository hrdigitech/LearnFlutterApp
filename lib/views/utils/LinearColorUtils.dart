import 'package:flutter/material.dart';

class LinearColorUtils {
  static LinearGradient primaryGradient() {
    return LinearGradient(
      colors: [
        Color(0xFF61D2C4),
        Color(0xFF29D890),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }

  static LinearGradient secondGradient() {
    return LinearGradient(
      colors: [
        Color(0xFFE5F8FF),
        Color(0xFFC6E2EF),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }
}
