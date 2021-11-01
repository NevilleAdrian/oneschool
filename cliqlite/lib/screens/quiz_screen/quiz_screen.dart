import 'package:cliqlite/providers/quiz_provider/quiz_provider.dart';
import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/quiz_screen/quiz_result.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/outline_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class QuizScreen extends StatefulWidget {
  static String id = 'quiz';

  QuizScreen({this.topicId});
  final String topicId;

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int indexNo;
  String selected;
  int score = 0;

  List<dynamic> expectedValues = [];
  List<dynamic> usersOption = [];
  List<dynamic> quizData;
  List<dynamic> quizResult;

  Future<List<dynamic>> futureQuiz;

  Future<List<dynamic>> futureTask() async {
    //Initialize provider
    QuizProvider quiz = QuizProvider.quizProvider(context);

    //Make call to get topics
    var result = await quiz.getQuiz(
      topicId: widget.topicId,
    );

    setState(() {
      quizResult = result;
    });
    expectedList(context);
    quizData = quizResult;

    print('result:${result[0]['resource']['type'][0]}');

    //Return future value
    return Future.value(result);
  }

  void expectedList(BuildContext context) {
    QuizProvider quiz = QuizProvider.quizProvider(context);
    expectedValues = (quizResult[quiz.number]['resource']['questions'] as List)
        ?.where((element) => !element['active'])
        ?.toList();
    print('expectedV: $expectedValues');
  }

  @override
  void initState() {
    // TODO: implement initState

    futureQuiz = futureTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Question Number
    QuizProvider quiz = QuizProvider.quizProvider(context);

    ThemeProvider theme = ThemeProvider.themeProvider(context);

    //Quiz type generator
    Widget getTestType(String type) {
      switch (type) {
        case 'trivia':
          return Column(
            children: [
              Image.asset(quizResult[quiz.number]['resource']['image'][0]),
              SizedBox(
                height: 40,
              ),
              Text(
                quizResult[quiz.number]['resource']['description'][0],
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

                            selected = quizResult[quiz.number]['resource']
                                ['option${index + 1}'][0];
                          });

                          if (selected ==
                              quizResult[quiz.number]['resource']
                                  ['correctAnswer'][0]) {
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
                                  if (quiz.number + 1 >= quizResult.length) {
                                    QuizProvider.quizProvider(context)
                                        .setNumber(0);
                                    score = score + 1;

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => QuizResult(
                                                score: score,
                                                aggregate: quizResult.length,
                                                topicId: widget.topicId)));
                                  } else {
                                    QuizProvider.quizProvider(context)
                                        .setNumber(quiz.number + 1);
                                    score = score + 1;

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
                                  if (quiz.number + 1 >= quizResult.length) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => QuizResult(
                                                score: score,
                                                aggregate: quizResult.length,
                                                topicId: widget.topicId)));
                                    QuizProvider.quizProvider(context)
                                        .setNumber(0);
                                  } else {
                                    QuizProvider.quizProvider(context)
                                        .setNumber(quiz.number + 1);
                                    expectedList(context);
                                    print('numberQuiz:${quiz.number}');
                                    print('quizResult:${quizResult.length}');
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
                              quizResult[quiz.number]['resource']
                                  ['option${index + 1}'][0],
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
        case 'gaps':
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              kSmallHeight,
              Column(
                children: [
                  Image.asset(quizData[quiz.number]['resource']['image'][0]),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    quizData[quiz.number]['resource']['description'][0],
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
                        itemCount: quizData[quiz.number]['resource']
                                ['questions']
                            .length,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: quizResult[quiz.number]['resource']
                                  ['questions']
                              .length,
                          // childAspectRatio: 1,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 30,
                        ),
                        itemBuilder: (context, index) {
                          var quizType = quizData[quiz.number]['resource']
                              ['questions'][index];
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
                        itemCount: quizResult[quiz.number]['resource']
                                ['options']
                            .length,
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 1.6,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 30,
                        ),
                        itemBuilder: (context, index) {
                          var quizName = quizResult[quiz.number]['resource']
                              ['options'][index]['name'];
                          return InkWell(
                            onTap: () {
                              setState(() {
                                indexNo = index;
                                selected = quizResult[quiz.number]['resource']
                                    ['options'][index]['name'];
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
                                            quizResult.length) {
                                          print('numberQuiz:${quiz.number}');
                                          print(
                                              'quizResult:${quizResult.length}');
                                          QuizProvider.quizProvider(context)
                                              .setNumber(0);

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      QuizResult(
                                                          score: score,
                                                          aggregate:
                                                              quizResult.length,
                                                          topicId:
                                                              widget.topicId)));
                                        } else {
                                          QuizProvider.quizProvider(context)
                                              .setNumber(quiz.number + 1);
                                          expectedList(context);
                                          print('numberQuiz:${quiz.number}');
                                          print(
                                              'quizResult:${quizResult.length}');
                                        }
                                      });
                                      indexNo = null;
                                      selected = null;
                                    });
                                  });
                                  print('wrong answer');
                                } else {
                                  var data = quizData
                                      .map(
                                        (e) => {
                                          ...e['resource'],
                                          "questions": (e['resource']
                                                  ["questions"])
                                              ?.map((f) => f["id"] ==
                                                      expectedValues[
                                                          currentLength]["id"]
                                                  ? {...f, "active": true}
                                                  : f)
                                              ?.toList()
                                        },
                                      )
                                      ?.first;
                                  quizData = quizData
                                      .map((e) => {...e, "resource": data})
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
                                              quizResult.length) {
                                            QuizProvider.quizProvider(context)
                                                .setNumber(0);
                                            score = score + 1;
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        QuizResult(
                                                            score: score,
                                                            aggregate:
                                                                quizResult
                                                                    .length,
                                                            topicId: widget
                                                                .topicId)));
                                          } else {
                                            QuizProvider.quizProvider(context)
                                                .setNumber(quiz.number + 1);
                                            score = score + 1;
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
                                print('score: $score');
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
      child: FutureHelper<List<dynamic>>(
        task: futureQuiz,
        loader: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [circularProgressIndicator()],
        ),
        builder: (context, _) => SafeArea(
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
                            style:
                                theme.status ? textStyleWhite : textLightBlack,
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
                              'Question ${quiz.number + 1}/${quizResult.length}',
                              style: theme.status
                                  ? textStyleWhite
                                  : textLightBlack)),
                    ],
                  ),
                  kSmallHeight,
                  StepProgressIndicator(
                    totalSteps: quizResult.length,
                    currentStep: quiz.number + 1,
                    selectedColor: theme.status ? secondaryColor : primaryColor,
                    unselectedColor: theme.status ? whiteColor : greyColor2,
                    roundedEdges: Radius.circular(20),
                  ),
                  SizedBox(height: 40),
                  getTestType(quizResult[quiz.number]['resource']['type'][0]),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
