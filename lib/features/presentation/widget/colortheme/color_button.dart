import 'package:expense_tracker/features/config/theme/theme.dart';
import 'package:expense_tracker/features/presentation/bloc/color_state_mangaement/color_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/color_state_mangaement/color_bloc.dart';

class ColorButton extends StatefulWidget {
  const ColorButton({super.key});

  @override
  State<ColorButton> createState() => _ColorButtonState();
}

class _ColorButtonState extends State<ColorButton> {
  AppThemeColor colorChoice = AppThemeColor.brown;
  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder:
              (context) => AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          colorChoice = AppThemeColor.brown;
                          print(colorChoice);
                        });
                      },
                      child: Text("Brown"),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          colorChoice = AppThemeColor.black;
                          print(colorChoice);
                        });
                      },
                      child: Text("Black"),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      if (colorChoice != null) {
                        themeBloc.add(
                          ChangeThemeEvent(selectedTheme: colorChoice),
                        );
                      }
                      Navigator.of(context).pop();
                    },
                    child: Text("Yes"),
                  ),
                ],
              ),
        );
      },
      child: Text("Color"),
    );
  }
}
