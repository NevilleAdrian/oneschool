import 'package:cliqlite/models/mock_data/mock_data.dart';
import 'package:cliqlite/providers/quiz_provider/quiz_provider.dart';
import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/quiz_screen/quiz_result.dart';
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

  List<dynamic> expectedValues = [];
  List<dynamic> usersOption = [];
  List<dynamic> quizData = [];

  void expectedList(BuildContext context) {
    QuizProvider quiz = QuizProvider.quizProvider(context);
    expectedValues = (quizTypes[quiz.number]['questions'] as List)
        ?.where((element) => !element['active'])
        ?.toList();
    print('expectedV: $expectedValues');
  }

  @override
  void initState() {
    // TODO: implement initState
    expectedList(context);
    quizData = quizTypes;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Question Number
    QuizProvider quiz = QuizProvider.quizProvider(context);

    String type = quizTypes[quiz.number]['type'];

    ThemeProvider theme = ThemeProvider.themeProvider(context);

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
                style: theme.status
                    ? textStyleWhite
                    : textLightBlack.copyWith(fontWeight: FontWeight.w600),
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
                            expectedList(context);
                            indexNo = index;
                            selected =
                                quizTypes[quiz.number]['option${index + 1}'];
                          });

                          if (selected ==
                              quizTypes[quiz.number]['correctAnswer']) {
                            Future.delayed(Duration(milliseconds: 700), () {
                              dialogBox(
                                  context,
                                  Container(
                                    height: 400,
                                    width: MediaQuery.of(context).size.width,
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          'assets/images/success.png',
                                        ),
                                        kSmallHeight,
                                        Text(
                                          'Success',
                                          style: smallPrimaryColor.copyWith(
                                              fontSize: 21,
                                              fontWeight: FontWeight.w600),
                                        )
                                      ],
                                    ),
                                  ), onTap: () {
                                Navigator.pop(context);
                                setState(() {
                                  if (quiz.number + 1 >= quizTypes.length) {
                                    QuizProvider.quizProvider(context)
                                        .setNumber(0);
                                    Navigator.pushNamed(context, QuizResult.id);
                                  } else {
                                    QuizProvider.quizProvider(context)
                                        .setNumber(quiz.number + 1);
                                    expectedList(context);
                                  }
                                });
                                indexNo = null;
                                selected = null;
                              });
                            });
                          } else {
                            Future.delayed(Duration(milliseconds: 700), () {
                              dialogBox(
                                  context,
                                  Container(
                                    height: 400,
                                    width: MediaQuery.of(context).size.width,
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
                                  ), onTap: () {
                                Navigator.pop(context);
                                setState(() {
                                  if (quiz.number + 1 >= quizTypes.length) {
                                    Navigator.pushNamed(context, QuizResult.id);
                                    QuizProvider.quizProvider(context)
                                        .setNumber(0);
                                  } else {
                                    QuizProvider.quizProvider(context)
                                        .setNumber(quiz.number + 1);
                                    expectedList(context);
                                    print('numberQuiz:${quiz.number}');
                                    print('quizTypes:${quizTypes.length}');
                                  }
                                });
                                indexNo = null;
                                selected = null;
                              });
                            });
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                              border: indexNo == index
                                  ? Border.all(color: primaryColor)
                                  : Border.all(
                                      width: 0.2,
                                      color: (theme.status
                                          ? whiteColor
                                          : greyColor)),
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
                                      : (theme.status
                                          ? whiteColor
                                          : blackColor)),
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
              Column(
                children: [
                  Image.asset(quizData[quiz.number]['image']),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    quizData[quiz.number]['description'],
                    style: textLightBlack.copyWith(
                        fontWeight: FontWeight.w600,
                        color: theme.status ? whiteColor : blackColor),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: 50,
                    child: GridView.builder(
                        itemCount: quizData[quiz.number]['questions'].length,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount:
                              quizTypes[quiz.number]['questions'].length,
                          // childAspectRatio: 1,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 30,
                        ),
                        itemBuilder: (context, index) {
                          var quizType =
                              quizData[quiz.number]['questions'][index];
                          return Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: quizType['active']
                                  ? (theme.status
                                      ? secondaryColor
                                      : lightPrimaryColor)
                                  : (theme.status ? whiteColor : greyColor),
                            ),
                            child: Text(
                              quizType['name'],
                              style: TextStyle(
                                  color: quizType['active']
                                      ? blackColor
                                      : (theme.status
                                          ? whiteColor
                                          : greyColor)),
                              textAlign: TextAlign.center,
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 500,
                    child: GridView.builder(
                        itemCount: quizTypes[quiz.number]['options'].length,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.6,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 30,
                        ),
                        itemBuilder: (context, index) {
                          var quizName =
                              quizTypes[quiz.number]['options'][index]['name'];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                indexNo = index;
                                selected = quizTypes[quiz.number]['options']
                                    [index]['name'];
                                expectedList(context);
                                usersOption = [...usersOption, selected];
                                var currentLength = usersOption.length - 1;
                                if (usersOption[currentLength].toLowerCase() !=
                                    expectedValues[currentLength]['name']
                                        .toLowerCase()) {
                                  Future.delayed(Duration(milliseconds: 700),
                                      () {
                                    dialogBox(
                                        context,
                                        Container(
                                          height: 400,
                                          width:
                                              MediaQuery.of(context).size.width,
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
                                        ), onTap: () {
                                      Navigator.pop(context);
                                      setState(() {
                                        if (quiz.number + 1 >=
                                            quizTypes.length) {
                                          print('numberQuiz:${quiz.number}');
                                          print(
                                              'quizTypes:${quizTypes.length}');
                                          QuizProvider.quizProvider(context)
                                              .setNumber(0);

                                          Navigator.pushNamed(
                                              context, QuizResult.id);
                                        } else {
                                          QuizProvider.quizProvider(context)
                                              .setNumber(quiz.number + 1);
                                          expectedList(context);
                                          print('numberQuiz:${quiz.number}');
                                          print(
                                              'quizTypes:${quizTypes.length}');
                                        }
                                      });
                                      indexNo = null;
                                      selected = null;
                                    });
                                  });
                                  print('wrong answer');
                                } else {
                                  quizData = quizData
                                      .map((e) => {
                                            ...e,
                                            "questions": (e["questions"]
                                                    as List)
                                                ?.map((f) => f["id"] ==
                                                        expectedValues[
                                                            currentLength]["id"]
                                                    ? {...f, "active": true}
                                                    : f)
                                                ?.toList()
                                          })
                                      ?.toList();
                                  if (usersOption.length ==
                                      expectedValues.length) {
                                    Future.delayed(Duration(milliseconds: 700),
                                        () {
                                      dialogBox(
                                          context,
                                          Container(
                                            height: 400,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                  'assets/images/success.png',
                                                ),
                                                kSmallHeight,
                                                Text(
                                                  'Success',
                                                  style: smallPrimaryColor
                                                      .copyWith(fontSize: 21),
                                                )
                                              ],
                                            ),
                                          ), onTap: () {
                                        Navigator.pop(context);
                                        setState(() {
                                          if (quiz.number + 1 >=
                                              quizTypes.length) {
                                            QuizProvider.quizProvider(context)
                                                .setNumber(0);
                                            Navigator.pushNamed(
                                                context, QuizResult.id);
                                          } else {
                                            QuizProvider.quizProvider(context)
                                                .setNumber(quiz.number + 1);
                                            expectedList(context);
                                          }
                                        });
                                        indexNo = null;
                                        selected = null;
                                      });
                                    });
                                    print('correct answer');
                                  }
                                }
                                print('expectedValues: $expectedValues');
                                print('usersOption: $usersOption');

                                print('selected: $selected');
                                print('indexNo: $indexNo');
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  border: indexNo == index
                                      ? Border.all(color: primaryColor)
                                      : Border.all(
                                          width: 0.2,
                                          color: theme.status
                                              ? whiteColor
                                              : greyColor),
                                  color: indexNo == index
                                      ? primaryColor
                                      : Colors.transparent,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: Text(
                                  quizName,
                                  style: textLightBlack.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: indexNo == index
                                          ? secondaryColor
                                          : (theme.status
                                              ? whiteColor
                                              : blackColor)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              )
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
                        child: Text(
                          'End Quiz',
                          style: theme.status ? textStyleWhite : textLightBlack,
                        )),
                  ],
                ),
                kSmallHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                            'Question ${quiz.number + 1}/${quizTypes.length}',
                            style: theme.status
                                ? textStyleWhite
                                : textLightBlack)),
                  ],
                ),
                kSmallHeight,
                StepProgressIndicator(
                  totalSteps: quizTypes.length,
                  currentStep: quiz.number + 1,
                  selectedColor: theme.status ? secondaryColor : primaryColor,
                  unselectedColor: theme.status ? whiteColor : greyColor2,
                  roundedEdges: Radius.circular(20),
                ),
                SizedBox(height: 40),
                getTestType(quizTypes[quiz.number]['type']),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
