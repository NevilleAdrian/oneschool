import 'package:cliqlite/auth/registration.dart';
import 'package:cliqlite/onboarding/onboarding.dart';
import 'package:cliqlite/splash/splashscreen.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cliq Lite',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute: SplashScreen.id,
      routes: {
        SplashScreen.id: (context) => SplashScreen(),
        OnboardingScreen.id: (context) => OnboardingScreen(),
        Registration.id: (context) => Registration(),
      },
    );
  }
}
