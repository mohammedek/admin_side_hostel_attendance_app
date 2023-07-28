
import 'package:cloud_firestore/cloud_firestore.dart';

class Meals {
  final bool wantAllDay;
  final bool isLunchSelected;
  final bool isBreakfastSelected;
  final bool isDinnerSelected;
  final DateTime? date;
  final DateTime? createdAt;
  final DateTime updatedAt;
  final String user;
  final String username;

  Meals({
    required this.wantAllDay,
    required this.isLunchSelected,
    required this.isBreakfastSelected,
    required this.isDinnerSelected,
    required this.date,
    this.createdAt,
    required this.updatedAt,
    required this.user,
    required this.username,
  });

  factory Meals.fromMap(Map<String, dynamic> map) {
    return Meals(
      wantAllDay: map['wantAllDay'] ?? false,
      isLunchSelected: map['lunch'] ?? false,
      isBreakfastSelected: map['breakfast'] ?? false,
      isDinnerSelected: map['dinner'] ?? false,
      createdAt: (map['createdAt'] as Timestamp?)?.toDate(),
      updatedAt: (map['updatedAt'] as Timestamp).toDate(),
      user: map['user'] ?? '',
      username: map['username'] ?? '',
      date: (map['updatedAt'] as Timestamp).toDate(),
    );
  }

  factory Meals.fromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return Meals.fromMap(data);
  }
}