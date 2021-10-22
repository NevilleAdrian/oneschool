import 'package:cliqlite/models/mock_data/mock_data.dart';
import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/quiz_screen/quiz_screen.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/outline_button.dart';
import 'package:flutter/material.dart';

class QuizResult extends StatefulWidget {
  static String id = 'result';
  @override
  _QuizResultState createState() => _QuizResultState();
}

class _QuizResultState extends State<QuizResult> {
  nextPage() {
    Navigator.pushNamed(context, AppLayout.id);
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = ThemeProvider.themeProvider(context);

    return BackgroundImage(
      child: SafeArea(
        child: Padding(
          padding: defaultVHPadding.copyWith(left: 60, right: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Quiz Result',
                textAlign: TextAlign.center,
                style: textStyleSmall.copyWith(
                    fontSize: 21.0,
                    fontWeight: FontWeight.w700,
                    color: theme.status ? secondaryColor : primaryColor),
              ),
              kLargeHeight,
              Image.asset('assets/images/trophy.png'),
              kSmallHeight,
              Text(
                'Congratulations!',
                style: textLightBlack.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 21,
                    color: theme.status ? whiteColor : blackColor),
                textAlign: TextAlign.center,
              ),
              kSmallHeight,
              Text(
                'Lorem ipsum dolor sit ame, consectr adipisc ing elit.',
                style: textExtraLightBlack.copyWith(
                    fontSize: 18.0,
                    color: theme.status ? whiteColor : blackColor),
                textAlign: TextAlign.center,
              ),
              kSmallHeight,
              Container(
                height: 1,
                width: 25.0,
                color: secondaryColor,
              ),
              kSmallHeight,
              Text(
                'YOUR SCORE',
                style: textExtraLightBlack.copyWith(
                    fontSize: 18.0,
                    color: theme.status ? whiteColor : blackColor),
                textAlign: TextAlign.center,
              ),
              kSmallHeight,
              Text(
                '1 / ${quizTypes.length}',
                textAlign: TextAlign.center,
                style: textStyleSmall.copyWith(
                    fontSize: 26.0,
                    fontWeight: FontWeight.w700,
                    color: primaryColor),
              ),
              kLargeHeight,
              LargeButton(
                submit: () => nextPage(),
                color: primaryColor,
                name: 'Take new quiz',
                height: 45,
                buttonColor: secondaryColor,
              ),
              kSmallHeight,
              LineButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => QuizScreen())),
                height: 45.0,
                text: 'Retake',
              )
            ],
          ),
        ),
      ),
    );
  }
}
