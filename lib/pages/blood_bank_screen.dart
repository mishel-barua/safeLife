import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BloodBankScreen extends StatefulWidget {
  @override
  _BloodBankScreenState createState() => _BloodBankScreenState();
}

class _BloodBankScreenState extends State<BloodBankScreen> {
  final TextEditingController _locationController = TextEditingController();
  List<DocumentSnapshot> _bloodBanks = [];

  void _searchBloodBanks() async {
    String location = _locationController.text.trim();

    if (location.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a location')),
      );
      return;
    }

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('blood_banks')
        .where('location', isEqualTo: location)
        .get();

    setState(() {
      _bloodBanks = querySnapshot.docs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Find Blood Bank')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Enter Location',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _searchBloodBanks,
              child: Text('Search'),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _bloodBanks.length,
                itemBuilder: (context, index) {
                  var bloodBank = _bloodBanks[index];
                  return Card(
                    child: ListTile(
                      title: Text(bloodBank['name']),
                      subtitle: Text('Location: ${bloodBank['location']}'),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
