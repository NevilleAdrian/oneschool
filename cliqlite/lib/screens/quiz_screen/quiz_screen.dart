import 'package:cliqlite/models/mock_data/mock_data.dart';
import 'package:cliqlite/providers/quiz_provider/quiz_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/outline_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class QuizScreen extends StatefulWidget {
  static String id = 'quiz';
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int indexNo;
  String selected;

  @override
  Widget build(BuildContext context) {
    // Question Number
    QuizProvider quiz = QuizProvider.quizProvider(context);

    String type = quizTypes[quiz.number]['type'];
    print('numberrr:${quiz.number}');

    //Quiz type generator
    Widget getTestType(String type) {
      switch (type) {
        case 'optionType':
          return Column(
            children: [
              Image.asset(quizTypes[quiz.number]['image']),
              SizedBox(
                height: 40,
              ),
              Text(
                quizTypes[quiz.number]['description'],
                style: textLightBlack.copyWith(fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                height: 400,
                child: GridView.builder(
                    itemCount: 4,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.6,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 30,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            indexNo = index;
                            selected =
                                quizTypes[quiz.number]['option${index + 1}'];
                            if (selected ==
                                quizTypes[quiz.number]['correctAnswer']) {
                              Future.delayed(Duration(milliseconds: 2000), () {
                                dialogBox(
                                    context,
                                    Container(
                                      height: 300,
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            'assets/images/success.png',
                                          ),
                                          kSmallHeight,
                                          Text(
                                            'Success',
                                            style: smallPrimaryColor.copyWith(
                                                fontSize: 21),
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () => Navigator.pop(context));
                              });

                              Future.delayed(Duration(milliseconds: 2000), () {
                                Navigator.of(context).pop();
                                indexNo = null;
                              });
                            } else {
                              Future.delayed(Duration(milliseconds: 2000), () {
                                dialogBox(
                                    context,
                                    Container(
                                      height: 300,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/failure.png',
                                            height: 150,
                                          ),
                                          kSmallHeight,
                                          Text(
                                            'Failure',
                                            style: redTextStyle.copyWith(
                                                fontSize: 21),
                                          )
                                        ],
                                      ),
                                    ),
                                    onTap: () => Navigator.pop(context));
                              });
                              Future.delayed(Duration(milliseconds: 2000), () {
                                Navigator.of(context).pop();
                                indexNo = null;
                              });
                            }
                            QuizProvider.quizProvider(context)
                                .setNumber(quiz.number + 1);
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              border: indexNo == index
                                  ? Border.all(color: primaryColor)
                                  : Border.all(width: 0.2, color: greyColor),
                              color: indexNo == index
                                  ? primaryColor
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Text(
                              quizTypes[quiz.number]['option${index + 1}'],
                              style: textLightBlack.copyWith(
                                  fontWeight: FontWeight.w400,
                                  color: indexNo == index
                                      ? secondaryColor
                                      : blackColor),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          );
        case 'completeType':
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SvgPicture.asset(quizTypes[quiz.number]['image']),
              kSmallHeight,
              Text('Complete Type')
            ],
          );
        default:
          return Container();
      }
    }

    return BackgroundImage(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: defaultVHPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                        onTap: () {
                          dialogBox(
                              context,
                              Container(
                                padding: defaultPadding,
                                height: 280,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Are you sure you want to end the quiz ',
                                      textAlign: TextAlign.center,
                                      style: textExtraLightBlack,
                                    ),
                                    kLargeHeight,
                                    LargeButton(
                                      name: 'Keep Playing',
                                      color: primaryColor,
                                      buttonColor: secondaryColor,
                                      submit: () => Navigator.pop(context),
                                    ),
                                    kSmallHeight,
                                    LineButton(
                                      text: 'End',
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    AppLayout()));
                                        quiz.setNumber(0);
                                      },
                                    )
                                  ],
                                ),
                              ),
                              onTap: () => Navigator.pop(context));
                        },
                        child: Text('End Quiz')),
                  ],
                ),
                kSmallHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                            'Question ${quiz.number + 1}/${quizTypes.length}')),
                  ],
                ),
                kSmallHeight,
                StepProgressIndicator(
                  totalSteps: quizTypes.length,
                  currentStep: quiz.number + 1,
                  selectedColor: primaryColor,
                  unselectedColor: greyColor2,
                  roundedEdges: Radius.circular(20),
                ),
                SizedBox(height: 40),
                getTestType(quizTypes[quiz.number]['type']),
                // QuizTypes(
                //   type: quizTypes[quiz.number - 1]['type'],
                //   number: quiz.number,
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
