import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:hostel_attendence_admin/app/all_data_screen/all_data_screen.dart';
import 'package:hostel_attendence_admin/app/constants.dart';

import '../admin_home/admin_side_home_screen.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

bool _showDialog = false;

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 1;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  late List<Widget> _pages;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      setState(() {
        _isConnected = result != ConnectivityResult.none;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    _pages = const [
      AdminAllDataScreen(),
      AdminSideHomeScreen(),
    ];
    return _showDialog
        ? WillPopScope(
      onWillPop: () async => false,
      child: Container(
        color: Colors.black.withOpacity(0.6),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    )
        : Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColor.accentColor,
          primaryColor: AppColor.accentColor,
          textTheme: Theme.of(context).textTheme.copyWith(
            bodySmall: const TextStyle(color: Colors.grey),
          ),
        ),
        child: AnimatedBottomNavigationBar(
          splashSpeedInMilliseconds: 200,
          iconSize: 35,
          backgroundColor: AppColor.secondary_color,
          icons: const [
            Icons.calendar_month,
            Icons.home_rounded,
            Icons.manage_history_rounded,
          ],
          activeIndex: _currentIndex,
          gapLocation: GapLocation.none,
          inactiveColor: AppColor.grey,
          activeColor: AppColor.accentColor,
          notchSmoothness: NotchSmoothness.softEdge,
          splashRadius: 2,
          splashColor: AppColor.secondary_color,
          gapWidth: 30,
          height: 53,
          // borderWidth: 30,
          borderColor: AppColor.grey,
          // leftCornerRadius: 10,
          // rightCornerRadius: 10,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}