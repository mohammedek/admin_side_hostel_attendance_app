import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants.dart';



class AppButton extends StatelessWidget {
  final Icon icon;
  final String text;
  final VoidCallback onPress;
  final Color color;
  const AppButton(
      {Key? key,
      required this.icon,
      required this.text,
      required this.onPress,
      required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double buttonWidth = MediaQuery.of(context).size.width * 0.8;
    return GestureDetector(
      onTap: onPress,
      child: Padding(
        padding: const EdgeInsets.all(9.0),
        child: Container(
          height: 50,
          width:buttonWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: AppColor.accentColor,

          ),
          child: Center(child: Text(text,style: GoogleFonts.poppins(
            textStyle:  const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColor.secondary_color
            )
          ),)),
        ),
      ),
    );
  }
}

