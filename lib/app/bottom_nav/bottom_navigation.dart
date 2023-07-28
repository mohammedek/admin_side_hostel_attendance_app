
import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:hostel_attendence_admin/app/constants.dart';
import '../screens/admin_home/admin_side_home_screen.dart';
import '../screens/all_data_screen/all_data_screen.dart';
import '../screens/canteen_seating_arrangment/canteen_seating_screen.dart';

class MyBottomNavigationBar extends StatefulWidget {
  const MyBottomNavigationBar({super.key});
  @override
  MyBottomNavigationBarState createState() => MyBottomNavigationBarState();
}

bool _showDialog = false;

class MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _currentIndex = 1;
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _pages =  [
      const AdminAllDataScreen(),
      const AdminSideHomeScreen(),
      const CanteenScreen()
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
          notchMargin: 20,
          blurEffect: true,
          leftCornerRadius: 10,
          rightCornerRadius: 10,
          splashSpeedInMilliseconds: 200,
          iconSize: 35,
          // backgroundColor: AppColor.secondary_color,
          
          icons: const [
            Icons.app_registration,
            Icons.home_rounded,
            Icons.table_bar_rounded
            // Icons.manage_history_rounded,
          ],
          activeIndex: _currentIndex,
          gapLocation: GapLocation.none,
          inactiveColor: AppColor.grey,
          activeColor: Colors.purple.shade300,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          splashRadius: 6,
          splashColor: AppColor.secondary_color,
          gapWidth: 30,
          height:70,
          // borderWidth: 30,
          borderColor: Colors.transparent,
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