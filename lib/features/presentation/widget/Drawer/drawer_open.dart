import 'package:flutter/material.dart';

class DrawerOpen extends StatelessWidget {
  final GlobalKey<ScaffoldState> drawerKey;
  const DrawerOpen({super.key, required this.drawerKey});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).cardColor,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              'John Doe',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).cardColor,
              ),
            ),

            currentAccountPicture: CircleAvatar(
              radius: 90,
              backgroundColor: Colors.orange,
              child: Text(
                'J',
                style: TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            otherAccountsPictures: [
              IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  drawerKey.currentState?.closeDrawer();
                },
              ),
            ],
            decoration: BoxDecoration(
              color:
                  Theme.of(context).scaffoldBackgroundColor, // Customize color

            ),
            accountEmail: null,
          ),
          // Drawer items (other items)
          Card(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListTile(
              title: Text('Home'),
              onTap: () {
                // Navigate to home
                Navigator.pop(context); // Close drawer
              },
            ),
          ),
          Card(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListTile(
              title: Text('Home'),
              onTap: () {
                // Navigate to home
                Navigator.pop(context); // Close drawer
              },
            ),
          ),
          Spacer(),
          ListTile(
            leading: IconButton(onPressed: (){}, icon: Icon(Icons.logout,color: Colors.red,)),
            title: Text("Logout"),
          )
        ],
      ),
    );
  }
}
