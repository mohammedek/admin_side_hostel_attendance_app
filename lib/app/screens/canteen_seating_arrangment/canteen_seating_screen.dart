import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CanteenScreen extends StatefulWidget {
  const CanteenScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _CanteenScreenState createState() => _CanteenScreenState();
}

class _CanteenScreenState extends State<CanteenScreen> {
  final CollectionReference<Map<String, dynamic>> _tableDataCollection =
  FirebaseFirestore.instance.collection('tableData');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Canteen Table'),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(5),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        scrollDirection: Axis.horizontal,
        childAspectRatio: 1.5,
        children: List.generate(10, (index) {
          final tableNumber = 'T${index + 1}';
          return CanteenTile(
            tableNumber: tableNumber,
            tableDataCollection: _tableDataCollection,
          );
        }),
      ),
    );
  }
}

class CanteenTile extends StatefulWidget {
  final String tableNumber;
  final CollectionReference<Map<String, dynamic>> tableDataCollection;

  const CanteenTile({
    Key? key,
    required this.tableNumber,
    required this.tableDataCollection,
  }) : super(key: key);

  @override
  _CanteenTileState createState() => _CanteenTileState();
}
class _CanteenTileState extends State<CanteenTile> {
  late Stream<DocumentSnapshot<Map<String, dynamic>>> _tableDataStream;
  late TextEditingController _notesController;
  late TextEditingController _quantityController;
  List<TableItem> _tableItems = [];

  @override
  void initState() {
    super.initState();
    _notesController = TextEditingController();
    _quantityController = TextEditingController();
    _tableDataStream = widget.tableDataCollection.doc(widget.tableNumber).snapshots();
    _initializeTableItems();
  }

  @override
  void dispose() {
    _notesController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

    void _clearTableItems() {
    setState(() {
      _tableItems.clear();
    });

    // Update Firestore data to remove all items for the table
    _updateFirestoreData();
  }

  

  Future<void> _initializeTableItems() async {
    final snapshot = await widget.tableDataCollection.doc(widget.tableNumber).get();
    final data = snapshot.data();
    if (data != null && data.containsKey('items')) {
      final items = data['items'] as List<dynamic>;
      _tableItems = items
          .map((item) => TableItem(name: item['name'], quantity: item['quantity']))
          .toList();
    }
     
    if(mounted) {
      setState(() {});
    }
  }
  


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: _tableDataStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = snapshot.data!.data();
        // _notesController.text = data?['notes'] ?? '';
        // _quantityController.text = (data?['quantity'] ?? 0).toString();

        return Card(
          elevation: 4, // Add elevation for a subtle shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // Rounded corners
          ),
          child: InkWell(
            onTap: () {
              _showAddDataDialog();
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                    
                      Text(
                        'Table ${widget.tableNumber}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                       IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: _clearTableItems,
                      ),
                    ],
                  ),
                  const Divider(), // Add a horizontal divider for visual separation
                  const SizedBox(height: 10),
                  const Text(
                    'Items : ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.black54,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: _tableItems.map((item) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${item.name.toUpperCase()}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                'QTY: ${item.quantity}',
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }



  void _showAddDataDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String itemName = '';
        int itemQuantity = 0;

        return AlertDialog(
          title: const Text(
            'Add Item',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  itemName = value;
                },
                decoration: const InputDecoration(
                  labelText: 'Item Name',
                ),
              ),
              TextField(
                onChanged: (value) {
                  itemQuantity = int.tryParse(value) ?? 0;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Item Quantity',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if(mounted) {
                  setState(() {
                    _tableItems.add(
                        TableItem(name: itemName, quantity: itemQuantity));
                  });
                }

                // Update Firestore data
                _updateFirestoreData();

                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _updateFirestoreData() {
    final List<Map<String, dynamic>> itemsData = _tableItems.map((item) {
      return {
        'name': item.name,
        'quantity': item.quantity,
      };
    }).toList();

    widget.tableDataCollection.doc(widget.tableNumber).update({
      'items': itemsData,
    }).then((_) {
      print('Firestore data updated successfully!');
    }).catchError((error) {
      print('Error updating Firestore data: $error');
    });
  }
}


class TableItem {
  final String name;
  final int quantity;

  TableItem({required this.name, required this.quantity});
}