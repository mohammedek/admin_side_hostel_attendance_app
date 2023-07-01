import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminSideHomeScreen extends StatefulWidget {
  const AdminSideHomeScreen({Key? key}) : super(key: key);

  @override
  AdminSideHomeScreenState createState() => AdminSideHomeScreenState();
}

class AdminSideHomeScreenState extends State<AdminSideHomeScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  File? _breakfastImage;
  File? _lunchImage;
  File? _dinnerImage;
  String? _selectedDay;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Side Home'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
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
                      child: Text(value),
                    );
                  },
                ).toList(),
                decoration: const InputDecoration(
                  labelText: 'Select Day',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Breakfast'),
              trailing: _breakfastImage != null
                  ? Image.file(
                _breakfastImage!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
                  : null,
              onTap: () => _pickImage(ImageSource.gallery, 'breakfast'),
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Lunch'),
              trailing: _lunchImage != null
                  ? Image.file(
                _lunchImage!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
                  : null,
              onTap: () => _pickImage(ImageSource.gallery, 'lunch'),
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('Dinner'),
              trailing: _dinnerImage != null
                  ? Image.file(
                _dinnerImage!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              )
                  : null,
              onTap: () => _pickImage(ImageSource.gallery, 'dinner'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (_selectedDay != null &&
                    _breakfastImage != null &&
                    _lunchImage != null &&
                    _dinnerImage != null) {
                  await saveMealDetails();
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text(
                          'Please select images and a day for all meals.'),
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
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveMealDetails() async {
    try {
      final mealDetailsRef = FirebaseFirestore.instance.collection('mealDetails');

      // Upload breakfast image
      final breakfastImageRef = await uploadImageToFirebaseStorage(_breakfastImage!, 'breakfast');
      final breakfastImageUrl = await breakfastImageRef.getDownloadURL();

      // Upload lunch image
      final lunchImageRef = await uploadImageToFirebaseStorage(_lunchImage!, 'lunch');
      final lunchImageUrl = await lunchImageRef.getDownloadURL();

      // Upload dinner image
      final dinnerImageRef = await uploadImageToFirebaseStorage(_dinnerImage!, 'dinner');
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

  Future<firebase_storage.Reference> uploadImageToFirebaseStorage(
      File imageFile, String mealType) async {
    final storageRef = firebase_storage.FirebaseStorage.instance.ref();
    final mealImageRef = storageRef.child('meal_images/$mealType.jpg');
    final uploadTask = mealImageRef.putFile(imageFile);
    await uploadTask.whenComplete(() => null);
    return mealImageRef;
  }
}
