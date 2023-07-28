import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../login_screen.dart';

class AdminSideHomeScreen extends StatefulWidget {
  const AdminSideHomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminSideHomeScreenState createState() => _AdminSideHomeScreenState();
}

class _AdminSideHomeScreenState extends State<AdminSideHomeScreen>
    with TickerProviderStateMixin {
  final ImagePicker _imagePicker = ImagePicker();
  File? _breakfastImage;
  File? _lunchImage;
  File? _dinnerImage;
  String? _selectedDay;
  bool _isUploading = false;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source, String mealType) async {
    final XFile? pickedImage = await _imagePicker.pickImage(source: source);
    if (pickedImage != null) {
      File? imageFile = File(pickedImage.path);
      if (mealType == 'breakfast') {
        setState(() {
          _breakfastImage = imageFile;
        });
      } else if (mealType == 'lunch') {
        setState(() {
          _lunchImage = imageFile;
        });
      } else if (mealType == 'dinner') {
        setState(() {
          _dinnerImage = imageFile;
        });
      }
    }
  }

  Future<firebase_storage.Reference> uploadImageToFirebaseStorage(
      File imageFile, String mealType) async {
    final storageRef = firebase_storage.FirebaseStorage.instance.ref();
    final mealImageRef = storageRef.child('meal_images/$mealType.jpg');
    final uploadTask = mealImageRef.putFile(imageFile);
    await uploadTask.whenComplete(() => null);
    return mealImageRef;
  }

  Future<void> saveMealDetails() async {
    try {
      final mealDetailsRef =
          FirebaseFirestore.instance.collection('mealDetails');

      setState(() {
        _isUploading = true;
      });

      // Upload breakfast image
      final breakfastImageRef =
          await uploadImageToFirebaseStorage(_breakfastImage!, 'breakfast');
      final breakfastImageUrl = await breakfastImageRef.getDownloadURL();

      // Upload lunch image
      final lunchImageRef =
          await uploadImageToFirebaseStorage(_lunchImage!, 'lunch');
      final lunchImageUrl = await lunchImageRef.getDownloadURL();

      // Upload dinner image
      final dinnerImageRef =
          await uploadImageToFirebaseStorage(_dinnerImage!, 'dinner');
      final dinnerImageUrl = await dinnerImageRef.getDownloadURL();

      final mealDetails = {
        'day': _selectedDay,
        'breakfastImage': breakfastImageUrl,
        'lunchImage': lunchImageUrl,
        'dinnerImage': dinnerImageUrl,
        'createdAt': DateTime.now(),
        'updatedAt': DateTime.now(),
        'user': 'admin',
      };

      await mealDetailsRef.add(mealDetails);

      setState(() {
        _selectedDay = null;
        _breakfastImage = null;
        _lunchImage = null;
        _dinnerImage = null;
        _isUploading = false;
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Success'),
          content: const Text('Meal details saved successfully.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Failed to save meal details.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Widget buildMealTile(String mealType, File? image, Function() onTap) {
    return ListTile(
      leading: const Icon(Icons.file_upload_outlined),
      title: Text(mealType),
      trailing: image != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.file(
                image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            )
          : null,
      onTap: onTap,
    );
  }

  Widget buildPaymentDetails() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          Text('Coming Soon', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget buildFeedbackViewer() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Feedback Viewer',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 8),
          Text('Coming Soon', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
  Future<void> _logout() async {
  try {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: 
      Text('Failed to logout. Please try again.')));
    print('Error during logout: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Home'),
        actions: [
           IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            _logout();
          },
        ),
        ]
      
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Colors.grey[200],
                child: DropdownButtonFormField<String>(
                  value: _selectedDay,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedDay = newValue;
                    });
                  },
                  items: <String>[
                    'Monday',
                    'Tuesday',
                    'Wednesday',
                    'Thursday',
                    'Friday',
                    'Saturday',
                    'Sunday',
                  ].map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      );
                    },
                  ).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Select Day',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            buildMealTile(
              'Breakfast',
              _breakfastImage,
              () => _pickImage(ImageSource.gallery, 'breakfast'),
            ),
            buildMealTile(
              'Lunch',
              _lunchImage,
              () => _pickImage(ImageSource.gallery, 'lunch'),
            ),
            buildMealTile(
              'Dinner',
              _dinnerImage,
              () => _pickImage(ImageSource.gallery, 'dinner'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _isUploading
                  ? null
                  : () async {
                      if (_selectedDay != null &&
                          _breakfastImage != null &&
                          _lunchImage != null &&
                          _dinnerImage != null) {
                        setState(() {
                          _isUploading = true;
                        });
                        await saveMealDetails();
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Error'),
                            content: const Text(
                              'Please select images and a day for all meals.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
              child: _isUploading
                  ? const SizedBox(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                        strokeWidth: 3.0,
                      ),
                    )
                  : const Text('Save'),
            ),
            buildPaymentDetails(),
            buildFeedbackViewer(),
          ],
        ),
      ),
    );
  }
}
