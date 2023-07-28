import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';
import 'package:hostel_attendence_admin/app/extenstions/date_time_extenstions.dart';

import '../../../gen/assets.gen.dart';
import '../../../model/meals_model.dart';


class AdminAllDataScreen extends StatefulWidget {
  const AdminAllDataScreen({Key? key}) : super(key: key);

  @override
  _AdminAllDataScreenState createState() => _AdminAllDataScreenState();
}

class _AdminAllDataScreenState extends State<AdminAllDataScreen> {
  late DateTime todayStart;
  late DateTime todayEnd;

  @override
  void initState() {
    super.initState();
    todayStart = _getStartOfDay();
    todayEnd = _getEndOfDay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Daily Data'),
        actions: [
          Text(DateTime.now().formatDay()),
          const Gap(10),
        ],
      ),
      body:StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collectionGroup('mealsHistory')
            .where('updatedAt', isGreaterThanOrEqualTo: todayStart)
            .where('updatedAt', isLessThanOrEqualTo: todayEnd)
            .snapshots(),
        builder: (context, snapshot) {
          try {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final mealsHistory = snapshot.data!.docs
                  .map((doc) => Meals.fromSnapshot(doc))
                  .toList();
              if (mealsHistory.isEmpty) {
                return const ListTile(
                  title: Text('No Student Registerd today'),
                );
              }

              return ListView.separated(
                cacheExtent: 3,
                itemCount: mealsHistory.length,
                itemBuilder: (context, index) {
                  final meal = mealsHistory[index];
                  final username = meal.username;
                  return ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    titleAlignment: ListTileTitleAlignment.threeLine,
                    title: Text(username,
                      style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),),
                    subtitle: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _buildMealHistoryList(meal),
                    ),
                  );
                }, separatorBuilder: (BuildContext context, int index) => const Divider(),
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          } catch (error) {
            return Center(child: Text('An error occurred: $error'));
          }
        },
      )

    );
  }

  List<Widget> _buildMealHistoryList(Meals meal) {
    final mealWidgets = <Widget>[];

    if (meal.isBreakfastSelected) {
      mealWidgets.add(
         Row(
          children: [
           Assets.breakfast.image(
               height: 50,
               width: 50
           ),
            const SizedBox(width: 8),
            const Text('Breakfast'),
          ],
        ),
      );
    }

    if (meal.isLunchSelected) {
      mealWidgets.add(
        Row(
          children: [
            Assets.lunch.image(
              height: 50,
              width: 50
            ),
            const SizedBox(width: 8),
            const Text('Lunch'),
          ],
        ),
      );
    }

    if (meal.isDinnerSelected) {
      mealWidgets.add(
        Row(
          children: [
           Assets.dinner.image(
               height: 50,
               width: 50
           ),
            const SizedBox(width: 8),
            const Text('Dinner'),
          ],
        ),
      );
    }

    if (mealWidgets.isEmpty) {
      mealWidgets.add(const Text('No meals for today'));
    }

    return mealWidgets;
  }

  DateTime _getStartOfDay() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  DateTime _getEndOfDay() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day, 23, 59, 59);
  }
}
