import 'dart:io';

import 'package:expense_tracker/weatherTest.dart';
import 'package:flutter/material.dart';

import '../../../data/data_sources/local_light/user_preferences.dart';
import '../../pages/setting/setting.dart';

class DrawerOpen extends StatefulWidget {
  final GlobalKey<ScaffoldState> drawerKey;
  const DrawerOpen({super.key, required this.drawerKey});

  @override
  State<DrawerOpen> createState() => _DrawerOpenState();
}

class _DrawerOpenState extends State<DrawerOpen> {
  File? _profileImage;
  String? _usernameController ;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }




  Future<void> _loadUserData() async {
    final username = await UserPreferences.getUsername();
    final imageFile = await UserPreferences.getProfileImageFile();

    if (username != null) _usernameController = username;
    if (imageFile != null) {
      setState(() {
        _profileImage = imageFile;
      });
    }
  }
  @override
  Widget build(BuildContext context) {

    return Drawer(
      backgroundColor: Theme.of(context).cardColor,
      child:Container(
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
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
              _usernameController! ?? "Empty",
                style: TextStyle(
                  fontSize: 18,
                  color:Colors.white,
                ),
              ),

              currentAccountPicture: CircleAvatar(
                radius: 90,
                backgroundColor: Colors.blue,
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

              otherAccountsPictures: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.cloud, color: Colors.blue, size: 20),
                      Text("35°C", style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],

              decoration: BoxDecoration(
                color:
                Colors.transparent, // Customize color
              ),
              accountEmail: null,
            ),
            // Drawer items (other items)
            SizedBox(height: 20),
            buildCardDrawer(context, Icons.edit, "Edit Profile",(){}),
            SizedBox(height: 20),
            buildCardDrawer(context, Icons.cloud, "Weather ForeCast",(){Navigator.of(context).push(MaterialPageRoute(builder: (context) => WeatherTest(),));}),
            SizedBox(height: 20),
            buildCardDrawer(context, Icons.settings, "Setting",(){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  SettingsPage()));

            }),
            Spacer(),
            ListTile(
              leading: IconButton(
                onPressed: () {},
                icon: Icon(Icons.logout, color: Colors.red),
              ),
              title: Text(
                "Logout",
                style: TextStyle(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCardDrawer(
    BuildContext context,
    IconData iconData,
    String title,
      VoidCallback onTap
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Card(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: ListTile(
          leading: Icon(iconData),
          title: Text(title),
          onTap:
            onTap,

        ),
      ),
    );
  }
}
