import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FindDonorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Find Donors')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').where('userType', isEqualTo: 'donor').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return CircularProgressIndicator();
          return ListView(
            children: snapshot.data!.docs.map((doc) => ListTile(
              title: Text(doc['name']),
              subtitle: Text('Blood Group: ${doc['bloodGroup']}, Location: ${doc['location']}'),
            )).toList(),
          );
        },
      ),
    );
  }
}
