import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hostel_attendence_admin/app/constants.dart';



class AppSnackBar extends SnackBar {
  final Widget content;
  final Duration duration;
  final Color ? color;

  AppSnackBar({super.key,
    this.color ,
    required this.duration,
    required this.content,
  }) : super(
    backgroundColor: color ?? Colors.black45,
    elevation: 2,
    showCloseIcon: true,
    behavior: SnackBarBehavior.fixed,
    content: Container(
      height: 40,
      child: Row(
        children: [
          AnimatedContainer(
            duration: duration,
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: AppColor.primary_color,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
       const  Gap(10),
          Expanded(child: content),
        ],
      ),
    ),
    duration: duration,
    shape: OutlineInputBorder(
      gapPadding: 3,
      borderSide: const BorderSide(color: AppColor.secondary_color),
      borderRadius: BorderRadius.circular(10),
    ),
  );
}
