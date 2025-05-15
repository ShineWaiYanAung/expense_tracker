import 'package:expense_tracker/features/config/route/route.dart';
import 'package:expense_tracker/features/presentation/bloc/color_state_mangaement/color_bloc.dart';
import 'package:expense_tracker/features/presentation/bloc/local_bloc_statement/local_expense_event.dart';
import 'package:expense_tracker/features/presentation/bloc/local_bloc_statement/local_expnese_bloc.dart';
import 'package:expense_tracker/features/presentation/pages/boardingScreen/onBoarding_screen.dart';
import 'package:expense_tracker/features/presentation/pages/home/dash_board.dart';
import 'package:expense_tracker/injection_container.dart';
import 'package:expense_tracker/weatherTest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/config/theme/theme.dart';
import 'features/presentation/bloc/color_state_mangaement/color_state.dart';
import 'features/presentation/widget/colortheme/color_button.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();

  final savedTheme = await ThemeBloc.loadSavedTheme(); // ✅ Get saved theme before runApp

  runApp(MyApp(initialTheme: savedTheme));
}

///BLOC done - Injection Done - BackEndNearly Complete , Need Test
class MyApp extends StatelessWidget {
  final AppThemeColor initialTheme;
  const MyApp({super.key, required this.initialTheme});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LocalExpenseBloc>(
          create: (context) => sl()..add(GetSavedExpense()),
        ),
        BlocProvider(create: (_) => ThemeBloc(initialTheme)),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (BuildContext context, state) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              scaffoldBackgroundColor: state.theme.scaffoldBackGroundColor,
              cardColor: state.theme.cardColor,
              buttonTheme: ButtonThemeData(buttonColor: state.theme.cardColor),
              textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                  textStyle: MaterialStateProperty.all<TextStyle>(
                    TextStyle(color: state.theme.buttonTextColor),
                  ),
                ),
              ),
              textTheme: TextTheme(
                titleLarge: TextStyle(color: state.theme.largeTextColor),
                titleMedium: TextStyle(color: state.theme.mediumTextColor),
              ),
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            routes: {dashBoard: (context) => DashBoard()},
            home: DashBoard(),
          );
        },
      ),
    );
  }
}
