import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BlackAuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String label;
  final String svgIcon;
  final FormFieldValidator<String>? validator;

  const BlackAuthField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.label,
    required this.svgIcon,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: h * 0.016,
          ),
        ),
        SizedBox(height: h * 0.01),
        TextFormField(
          controller: controller,
          validator: validator,
          obscureText: true,
          style: TextStyle(fontSize: h * 0.015, color: Colors.black),
          keyboardType: TextInputType.visiblePassword,
          decoration: InputDecoration(
            filled: false,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
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
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.black,
            ),
            prefixIcon: Padding(
              padding: EdgeInsets.all(h * 0.01),
              child: Container(
                height: h * 0.04,
                width: h * 0.04,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: SvgPicture.asset(
                  svgIcon,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
