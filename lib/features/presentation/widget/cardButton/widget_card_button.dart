import 'package:flutter/material.dart';
class cardWidget extends StatelessWidget {
  final Icon iconData;
  final VoidCallback onPressed;
  const cardWidget({
    super.key,
    required this.iconData,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).scaffoldBackgroundColor,
            blurRadius: 5,
            spreadRadius: 4,
          ),
        ],
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: IconButton(
        onPressed:onPressed,
        icon: iconData
      ),
    );
  }
}
