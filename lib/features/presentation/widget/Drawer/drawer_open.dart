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
              'RockerGyiTinSein',
              style: TextStyle(
                fontSize: 18,
                color: Theme.of(context).cardColor,
              ),
            ),

            currentAccountPicture: CircleAvatar(
              radius: 90,
              backgroundColor: Colors.blue,
              child: Text(
                'R',
                style: TextStyle(fontSize: 30, color: Colors.white),
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
                  Theme.of(context).scaffoldBackgroundColor, // Customize color

            ),
            accountEmail: null,
          ),
          // Drawer items (other items)
          SizedBox(height: 20,),
          buildCardDrawer(context,Icons.edit,"Edit Profile"),
          SizedBox(height: 20,),
          buildCardDrawer(context,Icons.cloud,"Weather ForeCast"),
          SizedBox(height: 20,),
          buildCardDrawer(context,Icons.settings,"Setting"),
          Spacer(),
          ListTile(
            leading: IconButton(onPressed: (){}, icon: Icon(Icons.logout,color: Colors.red,)),
            title: Text("Logout",style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),),
          )
        ],
      ),
    );
  }

  Widget buildCardDrawer(BuildContext context,IconData iconData,String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:10.0),
      child: Card(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: ListTile(
              leading: Icon(iconData),
              title: Text(title),
              onTap: () {
                // Navigate to home
                Navigator.pop(context); // Close drawer
              },
            ),
          ),
    );
  }
}
