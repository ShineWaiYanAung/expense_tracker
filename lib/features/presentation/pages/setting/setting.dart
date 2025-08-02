import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/data_sources/local_light/user_preferences.dart';
import '../home/dash_board.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  File? _profileImage;
  final TextEditingController _usernameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final username = await UserPreferences.getUsername();
    final imageFile = await UserPreferences.getProfileImageFile();

    if (username != null) _usernameController.text = username;
    if (imageFile != null) {
      setState(() {
        _profileImage = imageFile;
      });
    }
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      } else {
        // User canceled picking the image
        debugPrint('No image selected.');
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to pick image: $e')));
    }
  }

  // Future<void> _pickImage() async {
  //   final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     setState(() {
  //       _profileImage = File(pickedFile.path);
  //     });
  //   }
  // }

  Future<void> _saveSettings() async {
    if (_profileImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please select a profile picture."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final username = _usernameController.text.trim();
    await UserPreferences.setUsername(username);
    await UserPreferences.setProfileImagePath(_profileImage!.path);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Settings saved successfully!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).cardColor,
              Theme.of(context).scaffoldBackgroundColor,
              Theme.of(context).cardColor,
            ], // Start and end colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => DashBoard()),
                      );
                      // Navigator.of(context).pop(); // Use po
                    },
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).cardColor),
                    ),
                    width: 50,
                    child: Image.asset(
                      "asset/images/flags/uk.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey[300],
                  backgroundImage:
                      _profileImage != null ? FileImage(_profileImage!) : null,
                  child:
                      _profileImage == null
                          ? Icon(
                            Icons.camera_alt,
                            size: 30,
                            color: Colors.grey[700],
                          )
                          : null,
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                    focusedBorder: null,
                    prefixIconColor: Theme.of(context).cardColor,
                    prefixIcon: Icon(Icons.person),
                    filled: true,
                    focusColor: Theme.of(context).scaffoldBackgroundColor,
                    fillColor: Theme.of(context).scaffoldBackgroundColor,
                    hintText: "Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all<Color>(
                    Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
                onPressed: () {
                 _saveSettings();
                },
                child: Text(
                  "Submit",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
