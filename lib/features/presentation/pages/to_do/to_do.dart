import 'package:flutter/material.dart';

import '../home/dash_board.dart';

class ToDo extends StatelessWidget {
  const ToDo({super.key});


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

            ],
          ),
        ),
      ),
    );
  }
}