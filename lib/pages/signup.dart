import 'package:flutter/material.dart';
import 'package:savelife/firebase-service.dart';
import 'homescreen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  String _userType = 'donor';
  String _bloodGroup = 'A+';

  void _signup() async {
    var user = await _firebaseService.registerUser(
      _emailController.text,
      _passwordController.text,
      _nameController.text,
      _userType,
      _bloodGroup,
      _locationController.text,
    );

    if (user != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sign Up')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: _emailController, decoration: InputDecoration(labelText: 'Email')),
            TextField(controller: _passwordController, obscureText: true, decoration: InputDecoration(labelText: 'Password')),
            TextField(controller: _locationController, decoration: InputDecoration(labelText: 'Location')),

            DropdownButton<String>(
              value: _userType,
              items: ['donor', 'finder', 'bank'].map((e) => DropdownMenuItem(value: e, child: Text(e.toUpperCase()))).toList(),
              onChanged: (value) => setState(() => _userType = value!),
            ),
            DropdownButton<String>(
              value: _bloodGroup,
              items: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-'].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
              onChanged: (value) => setState(() => _bloodGroup = value!),
            ),

            ElevatedButton(onPressed: _signup, child: Text('Sign Up')),
          ],
        ),
      ),
    );
  }
}
