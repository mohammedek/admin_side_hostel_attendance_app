import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hostel_attendence_admin/app/bottom_nav/bottom_navigation.dart';
import 'package:hostel_attendence_admin/app/constants.dart';
import 'package:hostel_attendence_admin/app/widgets/custom_textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final List<String> authorizedEmails = [
    'mohammedmomz2223@gmail.com',
    'mohammedek159@gmail.com',
  ];

  final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _emailErrorText;
  String? _passwordErrorText;

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        if (authorizedEmails.contains(userCredential.user!.email)) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MyBottomNavigationBar()),
          );
        } else {
          showSnackBar('You are not authorized to access this app.');
        }
      } catch (e) {
        showSnackBar('Login failed. Please check your credentials.');
        print('Error during login: $e');
      }
    }
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Authentication')),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Only Canteen Adminstrator Would Have The Access To Login To This App",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const Gap(40),
              CustomTextField(
                  icon: const Icon(Icons.email),
                  controller: _emailController,
                  validation: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  isPassword: false,
                  type: TextInputType.emailAddress,
                  borderRadius: 20,
                  hintText: "Email"),
              const SizedBox(height: 16.0),
              CustomTextField(
                iconColor: AppColor.secondary_color,
                icon: Icon(Icons.lock),
                hintText: "Password",
                borderRadius: 20,
                type: TextInputType.visiblePassword,
                controller: _passwordController,
                isPassword: true,
                validation: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _login,
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
