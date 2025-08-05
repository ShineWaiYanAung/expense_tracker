import 'package:expense_tracker/features/presentation/pages/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/config/route/route.dart';
import 'features/config/theme/theme.dart';
import 'features/presentation/bloc/color_state_mangaement/color_bloc.dart';
import 'features/presentation/bloc/color_state_mangaement/color_state.dart';
import 'features/presentation/bloc/local_bloc_statement/local_expense_event.dart';
import 'features/presentation/bloc/local_bloc_statement/local_expnese_bloc.dart';
import 'features/presentation/pages/boardingScreen/onBoarding_screen.dart';
import 'features/presentation/pages/home/dash_board.dart';
import 'firebase_options.dart'; // if you're using flutterfire_cli
import 'package:firebase_core/firebase_core.dart';

import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase and dependencies
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await initializeDependencies();

  // Lock orientation
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Load saved theme
  final savedTheme = await ThemeBloc.loadSavedTheme();

  // Run app
  runApp(MyApp(initialTheme: savedTheme));
}

class MyApp extends StatelessWidget {
  final AppThemeColor initialTheme;
  const MyApp({super.key, required this.initialTheme});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // BlocProvider<LocalExpenseBloc>(
        //   create: (context) {
        //     final bloc = sl<LocalExpenseBloc>();
        //     // Delay the event to avoid blocking main thread
        //     Future.microtask(() => bloc.add(GetSavedExpense()));
        //     return bloc;
        //   },
        // ),
        BlocProvider<ThemeBloc>(
          create: (_) => ThemeBloc(initialTheme),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            title: 'Expense Tracker',
            debugShowCheckedModeBanner: false,
            theme: buildAppTheme(state.theme),
            home: const Login(),
            routes: {
              // dashBoard: (context) => const DashBoard(),
            },
          );
        },
      ),
    );
  }
  ThemeData buildAppTheme(AppTheme theme) {
    return ThemeData(
      scaffoldBackgroundColor: theme.scaffoldBackGroundColor,
      cardColor: theme.cardColor,
      buttonTheme: ButtonThemeData(buttonColor: theme.cardColor),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all<TextStyle>(
            TextStyle(color: theme.buttonTextColor),
          ),
        ),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(color: theme.largeTextColor, fontFamily: 'JetBrainsMono'),
        titleMedium: TextStyle(color: theme.mediumTextColor, fontFamily: 'JetBrainsMono'),
        bodyMedium: const TextStyle(fontFamily: 'JetBrainsMono'),
        // Add other styles if needed
      ),
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    );
  }

}
