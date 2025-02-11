import 'package:flutter/material.dart';
import 'finddonorscreen.dart';
import 'blood_bank_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => FindDonorsScreen())),
              child: Text('Find Blood Donors'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => BloodBankScreen())),
              child: Text('Find Blood Banks'),
            ),
          ],
        ),
      ),
    );
  }
}
