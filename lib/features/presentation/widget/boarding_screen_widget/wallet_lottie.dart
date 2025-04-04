import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
class WalletLottie extends StatelessWidget {
  const WalletLottie({super.key});

  @override
  Widget build(BuildContext context) {
    return Lottie.asset("lottie/boardingScreen/wallet_boarding_json.json");
  }
}
