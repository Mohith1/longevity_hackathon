// lib/profile.dart

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController =
      TextEditingController(text: 'Captain America');
  final TextEditingController _phoneController =
      TextEditingController(text: '0123456789');
  final TextEditingController _addressController =
      TextEditingController(text: 'Los Angeles');
  final TextEditingController _emailController =
      TextEditingController(text: 'captainamerica@gmail.com');

  final Map<String, bool> _isEditing = {
    'Name': false,
    'Phone': false,
    'Address': false,
    'Email': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/images/captain_america_dp.png'),
              ),
              const SizedBox(height: 20),
              _itemProfile('Name', _nameController, CupertinoIcons.person),
              const SizedBox(height: 10),
              _itemProfile('Phone', _phoneController, CupertinoIcons.phone),
              const SizedBox(height: 10),
              _itemProfile('Address', _addressController, CupertinoIcons.location),
              const SizedBox(height: 10),
              _itemProfile('Email', _emailController, CupertinoIcons.mail),
            ],
          ),
        ),
      ),
    );
  }

  Widget _itemProfile(
      String title, TextEditingController controller, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 5),
            color: Colors.blue.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          ),
        ],
      ),
      child: ListTile(
        title: Text(title),
        leading: Icon(iconData),
        horizontalTitleGap: 0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        trailing: IconButton(
          onPressed: () {
            setState(() {
              _isEditing[title] = !_isEditing[title]!;
              if (!_isEditing[title]!) {
                _showSnackBar(context, '$title saved');
                _saveData(title, controller.text);
              }
            });
          },
          icon: Icon(
            _isEditing[title]! ? Icons.check : Icons.edit,
            color: Colors.grey,
          ),
        ),
        tileColor: Colors.white,
        subtitle: _isEditing[title]!
            ? TextField(
                controller: controller,
                autofocus: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.bold),
              )
            : Text(
                controller.text,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Material(
          elevation: 4.0,
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 203, 231, 234),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text(message, style: const TextStyle(color: Colors.black)),
          ),
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.only(bottom: 80, left: 20, right: 20),
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  void _saveData(String title, String value) {
    print('Saving $title: $value');
  }
}
