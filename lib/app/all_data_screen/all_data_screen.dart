import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AdminAllDataScreen extends StatelessWidget {
  const AdminAllDataScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Data'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final users = snapshot.data!.docs;
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final userData = users[index].data() as Map<String, dynamic>;
              final username = userData['username'];
              final mealsHistory = userData['mealsHistory'] as List<dynamic>;
              return Card(
                child: ListTile(
                  title: Text(username),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: mealsHistory.map<Widget>((meal) {
                      final date = (meal['updatedAt'] as Timestamp).toDate();
                      final breakfast = meal['mealDetails']['breakfast'];
                      final lunch = meal['mealDetails']['lunch'];
                      final dinner = meal['mealDetails']['dinner'];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Text(
                              'Date: ${_formatDate(date)}',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10),
                            Text('Breakfast: $breakfast'),
                            const SizedBox(width: 10),
                            Text('Lunch: $lunch'),
                            const SizedBox(width: 10),
                            Text('Dinner: $dinner'),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    final formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(date);
  }
}
