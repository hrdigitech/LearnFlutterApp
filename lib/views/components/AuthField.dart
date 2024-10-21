import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String icon;
  final Color iconColor;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChnaged;

  const AuthField({
    super.key,
    required this.iconColor,
    required this.controller,
    required this.icon,
    required this.hintText,
    this.validator,
    this.onChnaged,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return TextFormField(
      controller: controller,
      validator: validator,
      onChanged: onChnaged,
      style: TextStyle(fontSize: h * 0.015, color: Colors.white),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        // Disable filled color
        filled: false,

        // White border for normal and error state
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.redAccent,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.redAccent,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),

        // Hint text styling
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white70, // Lighter white for hint text
        ),
        errorMaxLines: 3,

        prefixIcon: Padding(
          padding: EdgeInsets.all(
            h * 0.01,
          ),
          child: Container(
            height: h * 0.04,
            width: w * 0.04,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white, // White background for the icon
            ),
            child: SvgPicture.asset(
              icon,
            ),
          ),
        ),
      ),
    );
  }
}

class PassField extends StatefulWidget {
  final TextEditingController controller;
  final String icon;
  final Color iconColor;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChnaged;

  const PassField({
    super.key,
    required this.iconColor,
    required this.controller,
    required this.icon,
    required this.hintText,
    this.validator,
    this.onChnaged,
    this.keyboardType,
  });

  @override
  _PassFieldState createState() => _PassFieldState();
}

class _PassFieldState extends State<PassField> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      onChanged: widget.onChnaged,
      obscureText: !_showPassword, // Toggle password visibility
      style: TextStyle(fontSize: h * 0.015, color: Colors.white),
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        filled: false,
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: widget.hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        errorMaxLines: 3,

        prefixIcon: Padding(
          padding: EdgeInsets.all(h * 0.01),
          child: Container(
            height: h * 0.04,
            width: w * 0.04,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: SvgPicture.asset(widget.icon),
          ),
        ),
        // Toggle visibility icon
        suffixIcon: IconButton(
          icon: Icon(
            _showPassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _showPassword = !_showPassword;
            });
          },
        ),
      ),
    );
  }
}
