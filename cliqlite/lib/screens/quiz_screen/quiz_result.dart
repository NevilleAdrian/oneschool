import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/quiz_provider/quiz_provider.dart';
import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/quiz_screen/quiz_screen.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/outline_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class QuizResult extends StatefulWidget {
  static String id = 'result';

  QuizResult({this.score, this.aggregate, this.topicId, this.quizId});

  final int score;
  final int aggregate;
  final String topicId;
  final String quizId;
  @override
  _QuizResultState createState() => _QuizResultState();
}

class _QuizResultState extends State<QuizResult> {
  newQuiz() {
    Navigator.pushNamed(context, AppLayout.id);
  }

  retakeQuiz() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => QuizScreen(
                  topicId: widget.topicId,
                )));
  }

  @override
  void initState() {
    super.initState();
  }

  submitQuiz({bool type}) async {
    //Set Loader
    setState(() {
      AuthProvider.auth(context).setIsLoading(true);
    });
    try {
      //Submit Quiz
      var result = await QuizProvider.quizProvider(context)
          .submitQuiz(score: widget.score, quizId: widget.quizId);

      if (result != null) {
        setState(() {
          AuthProvider.auth(context).setIsLoading(false);
        });
        if (type) {
          //Route to home page
          newQuiz();
        } else {
          //Take Quiz again
          retakeQuiz();
        }
      }
    } catch (ex) {
      setState(() {
        AuthProvider.auth(context).setIsLoading(false);
      });
      showFlush(context, ex.toString(), primaryColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = ThemeProvider.themeProvider(context);
    AuthProvider auth = AuthProvider.auth(context);

    return BackgroundImage(
      child: ModalProgressHUD(
        inAsyncCall: auth.isLoading,
        progressIndicator: CircularProgressIndicator(
          strokeWidth: 7,
          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
        ),
        child: SingleChildScrollView(
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
                    '${widget.score} / ${widget.aggregate}',
                    textAlign: TextAlign.center,
                    style: textStyleSmall.copyWith(
                        fontSize: 26.0,
                        fontWeight: FontWeight.w700,
                        color: primaryColor),
                  ),
                  kLargeHeight,
                  LargeButton(
                    submit: () => submitQuiz(type: true),
                    color: primaryColor,
                    name: 'Take new quiz',
                    height: 45,
                    buttonColor: secondaryColor,
                  ),
                  kSmallHeight,
                  LineButton(
                    onPressed: () => submitQuiz(type: false),
                    height: 45.0,
                    text: 'Retake',
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
