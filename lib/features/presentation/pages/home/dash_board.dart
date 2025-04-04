import 'package:expense_tracker/features/presentation/bloc/color_state_mangaement/color_bloc.dart';
import 'package:flutter/material.dart';
import 'package:draggable_button_panel/draggable_button_panel.dart';
import '../../bloc/color_state_mangaement/color_event.dart';
import '../../bloc/color_state_mangaement/color_state.dart';
import '../../widget/cardButton/widget_card_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/theme/theme.dart';
class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  bool showPanel = true;
  final GlobalKey<DraggableButtonPanelState> _draggableButtonPanelKey =
  GlobalKey<DraggableButtonPanelState>();

   // Show the draggable button by default

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                children: [
                  buildTopBar(context),
                ],
              ),
            ),
            if (showPanel)
              BlocBuilder<ThemeBloc,ThemeState>(
                builder: (BuildContext context, state) {
                  return DraggableButtonPanel(
                    buttonColor: Theme.of(context).cardColor,
                    panelColor: Theme.of(context).scaffoldBackgroundColor,
                    key: _draggableButtonPanelKey,
                    top: 100,
                    options: [
                      IconButton(
                        icon:  Icon(Icons.circle,color: Colors.brown,),
                        onPressed: () {
                          context.read<ThemeBloc>().add(
                            ChangeThemeEvent(selectedTheme: AppThemeColor.brown),
                          );
                          print("Brown theme applied");
                        },

                      ),
                      IconButton(
                        icon:  Icon(Icons.circle,color: Colors.black,),
                        onPressed: () {
                          context.read<ThemeBloc>().add(
                            ChangeThemeEvent(selectedTheme: AppThemeColor.black),
                          );
                          print("Brown theme applied");
                        },
                      ),
                      IconButton(
                        icon:  Icon(Icons.circle,color: Colors.blue,),
                        onPressed: () {
                          context.read<ThemeBloc>().add(
                            ChangeThemeEvent(selectedTheme: AppThemeColor.blue),
                          );
                          print("Brown theme applied");
                        },
                      ),


                    ],
                  );
                },

              ),
          ],
        ),
      ),
    );
  }

  Row buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        cardWidget(iconData: Icon(Icons.menu, color: Theme.of(context).scaffoldBackgroundColor,), onPressed: () {

        }),
        cardWidget(
          iconData:Icon(Icons.palette, color:  !showPanel ? Theme.of(context).scaffoldBackgroundColor : Colors.red ,),
          onPressed: () {
            setState(() {
              print(showPanel);
              showPanel = !showPanel;
            });
          },
        ),
      ],
    );
  }
}
