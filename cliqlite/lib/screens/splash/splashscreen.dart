import 'dart:async';

import 'package:cliqlite/models/auth_model/auth_user/auth_user.dart';
import 'package:cliqlite/models/auth_model/first_time/first_time.dart';
import 'package:cliqlite/models/grades/grades.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/repository/hive_repository.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/auth/login.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/onboarding/onboarding.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splash_screen';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  //Initialize hive repository
  HiveRepository _hiveRepository = HiveRepository();

  //Initialize animation controller
  AnimationController controller;

  //Initialize animation
  Animation animation;

  //complete animation
  var _animationReady = Completer();

  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    controller.forward();

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _prepareAppState();
      }
    });
    controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  _prepareAppState() async {
    await HiveRepository.openHives([kUser, kFirst, kGrades]);
    AuthUser user;
    FirstTime first;
    List<Grades> grades;

    try {
      user = _hiveRepository.get<AuthUser>(key: 'user', name: kUser);
      grades = _hiveRepository.get<List<Grades>>(key: 'grades', name: kGrades);
    } catch (ex) {
      print(ex);
    }
    first = _hiveRepository.get<FirstTime>(key: 'first', name: kFirst);
    AuthProvider.auth(context).setFirst(first);

    if (first == null) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          OnboardingScreen.id, (Route<dynamic> route) => false);
    } else {
      if (user == null) {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(Login.id, (Route<dynamic> route) => false);
      } else {
        AuthProvider.auth(context).setUser(user);
        AuthProvider.auth(context).setGrades(grades);
        Navigator.of(context).pushNamedAndRemoveUntil(
            AppLayout.id, (Route<dynamic> route) => false);
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            height: controller.value * 100,
          ),
          kSmallWidth,
          SvgPicture.asset('assets/images/svg/text.svg'),
        ],
      )),
    );
  }
}
