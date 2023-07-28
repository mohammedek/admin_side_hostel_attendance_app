import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';
class CustomTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? Function(String?)? validation;
  final Color? iconColor;
  final bool isPassword;
  final TextInputType type;
  final double borderRadius;
  final String hintText;
  final Widget? icon;
  final int ?maxLenght;

  const CustomTextField({
    Key? key,
    required this.isPassword,
    required this.type,
    required this.borderRadius,
    required this.hintText,
    this.maxLenght,
    this.icon,
    this.validation,
    this.controller,
    this.iconColor
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 13.0, vertical: 15.0),
      child: TextFormField(
        maxLength: widget.maxLenght,
        style: GoogleFonts.inter(
          textStyle: const TextStyle(color: AppColor.secondary_color),
        ),
        cursorColor: AppColor.accentColor,
        controller: widget.controller,
        validator: widget.validation,
        obscureText: widget.isPassword ? _obscureText : false,
        keyboardType: widget.type,
        decoration: InputDecoration(
          errorStyle: const TextStyle(color: AppColor.primary_color),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.secondary_color),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.secondary_color),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: AppColor.secondary_color),
          ),
          focusColor: AppColor.primary_color,
          fillColor: AppColor.primary_color,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: AppColor.secondary_color,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          iconColor: const Color.fromARGB(255, 13, 5, 5),
          prefixIcon: widget.icon,
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              color: AppColor.primary_color,
            ),
            borderRadius: BorderRadius.circular(widget.borderRadius),
          ),
          suffixIcon: widget.isPassword
              ? GestureDetector(
            onTap: _toggleVisibility,
            child: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: AppColor.secondary_color,
            ),
          )
              : null,
        ),
      ),
    );
  }
}
