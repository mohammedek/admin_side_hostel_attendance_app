import 'package:flutter/material.dart';

class AppColor {
  static const primary_color = Colors.white;
  static const secondary_color = Colors.black;
  static const grey = Colors.grey;
  static const successColor = Colors.black87;
  static final  failureColor = Colors.deepPurple.shade700;
  static const accentColor = Colors.amber;
  static const accentColor2 = Colors.red;
}
class DeviceConfig{
  static final  screenSize = MediaQuery.of(context).size;
  static final  screenHeight = MediaQuery.of(context).size.height;
  static final  screenWidth = MediaQuery.of(context).size.width;
  static final  screenAspectRatio = MediaQuery.of(context).size.aspectRatio;



  static BuildContext get context => DeviceConfig.context;
}
