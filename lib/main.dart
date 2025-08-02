import 'package:expense_tracker/features/config/route/route.dart';
import 'package:expense_tracker/features/presentation/bloc/color_state_mangaement/color_bloc.dart';
import 'package:expense_tracker/features/presentation/bloc/local_bloc_statement/local_expense_event.dart';
import 'package:expense_tracker/features/presentation/bloc/local_bloc_statement/local_expnese_bloc.dart';
import 'package:expense_tracker/features/presentation/pages/boardingScreen/onBoarding_screen.dart';
import 'package:expense_tracker/features/presentation/pages/home/dash_board.dart';
import 'package:expense_tracker/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/config/theme/theme.dart';
import 'features/presentation/bloc/color_state_mangaement/color_state.dart';
import 'package:device_frame/device_frame.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  final savedTheme = await ThemeBloc.loadSavedTheme();

  runApp(
     MyApp(initialTheme: savedTheme)
  );
}


//
// class MyFramedApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding:EdgeInsets.symmetric(horizontal: 100),
//       child: Directionality(
//         textDirection: TextDirection.ltr, // or rtl if needed
//         child: DeviceFrame(
//           device: Devices.ios.iPhone13,
//           screen: Container(
//             color: Colors.black,
//             child: Center(
//               child: Text('Your App Here'),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

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
                    TextStyle(color: state.theme.buttonTextColor,),
                  ),
                ),
              ),
              textTheme: TextTheme(
                displayLarge: TextStyle(fontFamily: 'JetBrainsMono'),
                displayMedium: TextStyle(fontFamily: 'JetBrainsMono'),
                displaySmall: TextStyle(fontFamily: 'JetBrainsMono'),
                headlineLarge: TextStyle(fontFamily: 'JetBrainsMono'),
                headlineMedium: TextStyle(fontFamily: 'JetBrainsMono'),
                headlineSmall: TextStyle(fontFamily: 'JetBrainsMono'),
                titleLarge: TextStyle(color: state.theme.largeTextColor, fontFamily: 'JetBrainsMono'),
                titleMedium: TextStyle(color: state.theme.mediumTextColor, fontFamily: 'JetBrainsMono'),
                titleSmall: TextStyle(fontFamily: 'JetBrainsMono'),
                bodyLarge: TextStyle(fontFamily: 'JetBrainsMono'),
                bodyMedium: TextStyle(fontFamily: 'JetBrainsMono'),
                bodySmall: TextStyle(fontFamily: 'JetBrainsMono'),
                labelLarge: TextStyle(fontFamily: 'JetBrainsMono'),
                labelMedium: TextStyle(fontFamily: 'JetBrainsMono'),
                labelSmall: TextStyle(fontFamily: 'JetBrainsMono'),
              ),

              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            ),
            routes: {dashBoard: (context) => DashBoard()},
            home:OnboardingScreen()
          );
        },
      ),
    );
  }
}
