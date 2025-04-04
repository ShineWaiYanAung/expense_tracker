import 'package:flutter/material.dart';

//Enum Data Type
enum AppThemeColor{
  brown,
  black,
  blue,
  green
}
// Abstract class defining the contract for app themes
abstract class AppTheme {
  late Color scaffoldBackGroundColor;
  late Color gradientFirstColor;
  late Color gradientSecondColor;
  late Color largeTextColor;
  late Color mediumTextColor;
  late Color buttonTextColor;
  late Color cardColor;
  late Color unSelectedTextColor;
  late Color focusTextColor;

}

// Factory class to create appropriate theme instances
class AppThemeFactory {
  static AppTheme getAppThemeFactory(AppThemeColor type ) {
    switch ( type){
      case AppThemeColor.brown :
        return BrownTheme();
      case AppThemeColor.black :
        return BlackTheme();
      case AppThemeColor.blue :
        return BlueTheme();
      default :
        return BrownTheme();
    }
  }
}

// Implementation of WhiteTheme
class BrownTheme implements AppTheme {
  @override
  Color buttonTextColor = Colors.white;

  @override
  Color focusTextColor = Color(0xff62412C);

  @override
  Color gradientFirstColor = Color(0xff81BCF0);

  @override
  Color gradientSecondColor = Color(0xff497ADD);

  @override
  Color largeTextColor = Colors.white;

  @override
  Color mediumTextColor = Colors.white;

  @override
  Color scaffoldBackGroundColor = Color(0xFFF0EDEA);

  @override
  Color unSelectedTextColor = Colors.black45;

  @override
  Color cardColor = Color(0xff6D4831);


}
class BlackTheme implements AppTheme {
  @override
  Color buttonTextColor = Colors.white;

  @override
  Color focusTextColor = Color(0xff2C2723);

  @override
  Color gradientFirstColor = Color(0xff81BCF0);

  @override
  Color gradientSecondColor = Color(0xff497ADD);

  @override
  Color largeTextColor = Colors.white;

  @override
  Color mediumTextColor = Colors.white;

  @override
  Color scaffoldBackGroundColor = Color(0xFFF0EDEA);

  @override
  Color unSelectedTextColor = Colors.black45;

  @override
  Color cardColor = Color(0xff2C2723);
}
class BlueTheme implements AppTheme {
  @override
  Color buttonTextColor = Colors.black;

  @override
  Color focusTextColor = Color(0xff2C2723);

  @override
  Color gradientFirstColor = Color(0xff81BCF0);

  @override
  Color gradientSecondColor = Color(0xff497ADD);

  @override
  Color largeTextColor = Colors.white;


  @override
  Color mediumTextColor =  Colors.white;

  @override
  Color scaffoldBackGroundColor = Color(0xFFF0EDEA);

  @override
  Color unSelectedTextColor = Colors.black45;

  @override
  Color cardColor =Color(0xff81BCF0);
}
