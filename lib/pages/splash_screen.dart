import 'package:farm_solve/pages/onboarding_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
       splash: "lib/images/farm_logo.png",
      nextScreen: OnboardingScreen(),
      splashTransition: SplashTransition.rotationTransition,

    );
  }
}
