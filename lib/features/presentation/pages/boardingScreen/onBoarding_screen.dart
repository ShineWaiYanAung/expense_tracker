import 'package:expense_tracker/features/presentation/widget/boarding_screen_widget/wallet_lottie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:slide_action/slide_action.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //LottieAni
              SizedBox(height: 40),
              Center(
                child: SizedBox(width: 350, height: 300, child: WalletLottie()),
              ),

              //ContainerCard
              Container(
                margin: EdgeInsets.only(top: 80),
                height: 300,
                width: 350,
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 20),

                    Text(
                      "Track Your Expense",
                      style: TextButtonTheme.of(
                        context,
                      ).style?.textStyle?.resolve({})?.copyWith(fontSize: 30,color: Theme.of(context).scaffoldBackgroundColor),
                    ),

                    Text(
                      "Stay in control of your \n finances.",
                      textAlign: TextAlign.center,
                      style: TextButtonTheme.of(context).style?.textStyle
                          ?.resolve({})
                          ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold,color: Theme.of(context).scaffoldBackgroundColor),
                    ),

                    buildEntrySlideCard(context),
                  ],
                ),
              ),
            ],
          ),
        )

      ),
    );
  }

  Widget buildEntrySlideCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: SlideAction(
        trackBuilder: (context, state) {
          final double percentage = state.thumbFractionalPosition * 100;
          final String result = percentage.toStringAsFixed(
            0,
          ); // Ensures whole number without scientific notation

          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Theme.of(context).scaffoldBackgroundColor,
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 8),
              ],
            ),
            child: Center(
              child: Text(
                state.isPerformingAction
                    ? "Loading..."
                    : "Swipe To Enter : ${result}%",
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
        thumbBuilder: (context, state) {
          return Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child:
                state.isPerformingAction
                    ? const CupertinoActivityIndicator(color: Colors.white)
                    : const Center(
                      child: Icon(Icons.chevron_right, color: Colors.white),
                    ),
          );
        },
        action: () async {
          // Async operation
          await Future.delayed(
            const Duration(seconds: 2),
            () => Navigator.of(context).pushNamed("/dashBoard"),
          );
        },
      ),
    );
  }
}
