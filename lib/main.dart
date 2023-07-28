import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hostel_attendence_admin/app/bottom_nav/bottom_navigation.dart';
import 'package:hostel_attendence_admin/app/screens/login_screen.dart';
import 'package:hostel_attendence_admin/app/screens/splash_screen.dart';


Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 await  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hostel Admin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:  const SplashScreen()
    );
  }
}


