import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:flutter/material.dart';

class BackgroundImage extends StatefulWidget {
  BackgroundImage({this.child});

  final Widget child;
  @override
  _BackgroundImageState createState() => _BackgroundImageState();
}

class _BackgroundImageState extends State<BackgroundImage> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = ThemeProvider.themeProvider(context);
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(theme.background),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: widget.child,
      ),
    );
  }
}

class OnBoardingBackground extends StatefulWidget {
  OnBoardingBackground({this.child});

  final Widget child;
  @override
  _OnBoardingBackgroundState createState() => _OnBoardingBackgroundState();
}

class _OnBoardingBackgroundState extends State<OnBoardingBackground> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/onboarding-bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}
