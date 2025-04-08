import 'package:expense_tracker/features/config/route/route.dart';
import 'package:expense_tracker/features/presentation/bloc/color_state_mangaement/color_bloc.dart';
import 'package:expense_tracker/features/presentation/bloc/local_bloc_statement/local_expense_event.dart';
import 'package:expense_tracker/features/presentation/bloc/local_bloc_statement/local_expnese_bloc.dart';
import 'package:expense_tracker/features/presentation/pages/boardingScreen/onBoarding_screen.dart';
import 'package:expense_tracker/features/presentation/pages/home/dash_board.dart';
import 'package:expense_tracker/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/presentation/bloc/color_state_mangaement/color_state.dart';
import 'features/presentation/widget/colortheme/color_button.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  runApp(const MyApp());
}

///BLOC done - Injection Done - BackEndNearly Complete , Need Test
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocalExpenseBloc>(
          create: (context) => sl()..add(GetSavedExpense()),
        ),
        BlocProvider(create: (context) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(
                      color: state.theme.buttonTextColor,
                    ), // Customize as needed
                  ),
                ),
              ),
              scaffoldBackgroundColor: state.theme.scaffoldBackGroundColor,
              cardColor: state.theme.cardColor,
              buttonTheme: ButtonThemeData(buttonColor: state.theme.cardColor),
              textTheme: TextTheme(
                titleLarge: TextStyle(color: state.theme.largeTextColor),
                titleMedium: TextStyle(color: state.theme.mediumTextColor),
              ),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            routes: {dashBoard: (context) => DashBoard()},
            home: OnboardingScreen(),
          );
        },
      ),
    );
  }
}
