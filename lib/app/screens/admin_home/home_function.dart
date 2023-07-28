import 'package:cloud_firestore/cloud_firestore.dart';

// Get a reference to the "attendees" collection
CollectionReference attendeesCollection = FirebaseFirestore.instance.collection('users');

// Retrieve all documents from the collection
Future<void> getAttendees() async {
  try {
    QuerySnapshot snapshot = await attendeesCollection.get();
    // Access the documents in the snapshot
    for (QueryDocumentSnapshot doc in snapshot.docs) {
      // Access the data of each document
      Object? data = doc.data();
      // Do something with the data
      print(data);
    }
  } catch (e) {
    print('Error retrieving attendees: $e');
  }
}

// Call the function to retrieve the attendees
