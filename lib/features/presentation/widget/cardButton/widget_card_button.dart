import 'dart:ui';

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
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12, // shadow color
                blurRadius: 10,        // softness of the shadow
                spreadRadius: 2,       // how far the shadow spreads
                offset: Offset(0, 4),  // shadow position (x, y)
              ),
            ],
            color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.4),

          ),
          child: IconButton(onPressed: onPressed, icon: iconData,),
        ),
      ),
    );
  }
}
