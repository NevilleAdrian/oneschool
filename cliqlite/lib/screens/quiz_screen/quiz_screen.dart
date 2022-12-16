import 'package:cliqlite/providers/quiz_provider/quiz_provider.dart';
import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/home/home.dart';
import 'package:cliqlite/screens/quiz_screen/quiz_result.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/outline_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:cliqlite/utils/text_box.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class QuizScreen extends StatefulWidget {
  static String id = 'quiz';

  QuizScreen({this.topicId, this.subjectId, this.name, this.type});
  final String topicId;
  final String subjectId;
  final String name;
  final String type;

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  List<dynamic> expectedValues = [];
  List<dynamic> usersOption = [];

  int indexNo;
  String selected;
  int score = 0;

  List<dynamic> quizData;
  List<dynamic> quizResult;
  // String quizId;

  bool show = false;
  bool click = false;
  bool showBottomBar = false;
  String showAnswerBox = '';

  Future<List<dynamic>> futureQuiz;

  Future<List<dynamic>> futureTask() async {
    //Initialize provider
    QuizProvider quiz = QuizProvider.quizProvider(context);
    // Make call to get topics
    var result;

    try {
      if (widget.type == 'quick') {
        result = await quiz.getQuickQuiz(widget.subjectId);
      } else {
        result = await quiz.getQuiz(
            topicId: widget.topicId,
            // subjectId: widget.subjectId,
            // name: widget.name,
            buildContext: context);
      }
    } catch (ex) {}

    // result = quizzData;

    setState(() {
      quizResult = result;
      // quizId = result[0]['_id'];
    });
    // expectedList(context);
    quizData = quizResult;

    //Return future value
    return Future.value(result);
  }

  // void expectedList(BuildContext context) {
  //   QuizProvider quiz = QuizProvider.quizProvider(context);
  //   expectedValues = (quizResult[quiz.number]['resource']['questions'] as List)
  //       ?.where((element) => !element['active'])
  //       ?.toList();
  // }

  successfulQuiz(QuizProvider quiz, {String gap}) {
    if (gap == 'gap') {
      Navigator.pop(context);
    }
    setState(() {
      if (quiz.number + 1 >= quizResult.length) {
        //Set Number to 0
        QuizProvider.quizProvider(context).setNumber(0);

        //Increment score
        score = score + 1;

        //Submit Quiz
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuizResult(
                      score: score,
                      type: widget.type == 'quick' ? 'quick' : '',
                      aggregate: quizResult.length,
                      topicId: widget.type == 'quick'
                          ? quizResult[quiz.number]['topic']['_id']
                          : widget.topicId,
                      quizId: quizResult[quiz.number]['quiz']['_id'],
                    )));
      } else {
        QuizProvider.quizProvider(context).setNumber(quiz.number + 1);
        score = score + 1;
        // expectedList(context);
      }
    });
    indexNo = null;
    selected = null;
  }

  failedQuiz(QuizProvider quiz, {String gap}) {
    if (gap == 'gap') {
      Navigator.pop(context);
    }
    setState(() {
      if (quiz.number + 1 >= quizResult.length) {
        //Set Number to 0
        QuizProvider.quizProvider(context).setNumber(0);

        //Submit Quiz
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuizResult(
                      score: score,
                      aggregate: quizResult.length,
                      type: widget.type == 'quick' ? 'quick' : '',
                      topicId: widget.type == 'quick'
                          ? quizResult[quiz.number]['topic']['_id']
                          : widget.topicId,
                      quizId: quizResult[quiz.number]['quiz']['_id'],
                    )));
      } else {
        QuizProvider.quizProvider(context).setNumber(quiz.number + 1);
        // expectedList(context);
      }
    });
    indexNo = null;
    selected = null;
  }

  Widget explanation({String selected, String answer, int index, int number}) {
    if (selected != answer && index == number) {
      return YellowButton(
        text: 'Check Answer',
        onTap: () {
          setState(() {
            show = !show;
          });
          print(show);
        },
      );
    } else {
      return Container();
    }
  }

  Widget answerBox(
      {QuizProvider quiz,
      String text,
      String image,
      Color buttonColor,
      Color textColor,
      Color bgColor,
      Function onTap}) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(color: bgColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Image.asset(image),
                kVerySmallWidth,
                Expanded(
                  child: Text(
                    text,
                    style: smallPrimaryColor.copyWith(
                        fontSize: 15,
                        color: textColor,
                        fontWeight: FontWeight.w600),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: GreenButton(
              submit: onTap,
              color: primaryColor,
              name: 'Continue',
              buttonColor: buttonColor,
              loader: false,
              gradColor: buttonColor,
            ),
          )
        ],
      ),
    );
  }

  Widget answerWidget(
      {String selected,
      String answer,
      int length,
      String type,
      QuizProvider quiz}) {
    if (selected == answer && selected != null) {
      return answerBox(
          quiz: quiz,
          text: 'Correct!  You got 5 points!',
          image: 'assets/images/smile.png',
          textColor: primaryColor,
          bgColor: secondaryColor,
          onTap: () {
            successfulQuiz(quiz);
            setState(() {
              click = !click;
              expectedValues = [];
              usersOption = [];
              showBottomBar = !showBottomBar;
              show = false;
            });
          });
    } else if (selected != answer && selected != null) {
      return answerBox(
          quiz: quiz,
          text: 'Oops! That’s wrong',
          image: 'assets/images/frown.png',
          textColor: redColor,
          bgColor: lightRedColor,
          buttonColor: redColor,
          onTap: () {
            failedQuiz(quiz);
            setState(() {
              click = !click;
              expectedValues = [];
              usersOption = [];
              showBottomBar = !showBottomBar;
              show = false;
            });
          });
    } else {
      return Container();
    }
  }

  Widget gapWidget({String type, QuizProvider quiz}) {
    if (showAnswerBox == 'fail') {
      return answerBox(
          quiz: quiz,
          text: 'Oops! That’s wrong',
          image: 'assets/images/frown.png',
          textColor: redColor,
          bgColor: lightRedColor,
          buttonColor: redColor,
          onTap: () {
            failedQuiz(quiz);
            setState(() {
              expectedValues = [];
              usersOption = [];
              showAnswerBox = '';
              quizData = quizResult;
              selected = '';
              showBottomBar = !showBottomBar;
              // quizData.removeAt(0);
              print('quizdata:$quizData');
            });
          });
    } else if (showAnswerBox == 'pass') {
      return answerBox(
          quiz: quiz,
          text: 'Correct!  You got 5 points',
          image: 'assets/images/smile.png',
          textColor: primaryColor,
          bgColor: secondaryColor,
          onTap: () {
            successfulQuiz(quiz);
            setState(() {
              expectedValues = [];
              usersOption = [];
              showAnswerBox = '';
              quizData = quizResult;
              selected = '';
              showBottomBar = !showBottomBar;
              // quizData.removeAt(0);
            });
          });
    } else {
      return Container();
    }
  }

  //Quiz type generator
  Widget getTestType(String type) {
    QuizProvider quiz = QuizProvider.quizProvider(context);
    ThemeProvider theme = ThemeProvider.themeProvider(context);

    switch (type) {
      case 'trivia':
        return SingleChildScrollView(
          child: Column(
            children: [
              // Image.asset(quizResult[quiz.number]['resource']['image'][0]),
              // SizedBox(
              //   height: 40,
              // ),
              Container(
                padding: defaultPadding,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Text(
                        quizResult[quiz.number]['description'],
                        style: smallPrimaryColor.copyWith(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 60,
              ),
              Column(
                children: [
                  !show
                      ? Container(
                          padding: defaultPadding,
                          height: 350,
                          child: GridView.builder(
                              itemCount: 4,
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio: 5,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 10,
                              ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                  onTap: click
                                      ? null
                                      : () {
                                          setState(() {
                                            // expectedList(context);
                                            indexNo = index;
                                            // selected = quizResult[quiz.number]
                                            //     ['option${index + 1}'];
                                            selected = returnLetter(index + 1);
                                            click = !click;
                                            showBottomBar = !showBottomBar;
                                            print('selected: $selected');
                                            print(
                                                'correctAnswer: ${quizResult[quiz.number]['correctAnswer']}');
                                          });

                                          // if (selected ==
                                          //     quizResult[quiz.number]['resource']
                                          //         ['correctAnswer'][0]) {
                                          //   Future.delayed(Duration(milliseconds: 700), () {
                                          //     dialogBox(
                                          //         context,
                                          //         Container(
                                          //           height: 400,
                                          //           width: MediaQuery.of(context).size.width,
                                          //           child: Column(
                                          //             children: [
                                          //               Image.asset(
                                          //                 'assets/images/success.png',
                                          //               ),
                                          //               kSmallHeight,
                                          //               Text(
                                          //                 'Success',
                                          //                 style: smallPrimaryColor.copyWith(
                                          //                     fontSize: 21,
                                          //                     fontWeight: FontWeight.w600),
                                          //               )
                                          //             ],
                                          //           ),
                                          //         ),
                                          //         onTap: () => successfulQuiz(quiz));
                                          //   });
                                          // } else {
                                          //   Future.delayed(Duration(milliseconds: 700), () {
                                          //     dialogBox(
                                          //         context,
                                          //         Container(
                                          //           height: 400,
                                          //           width: MediaQuery.of(context).size.width,
                                          //           child: Column(
                                          //             mainAxisAlignment:
                                          //                 MainAxisAlignment.center,
                                          //             children: [
                                          //               Image.asset(
                                          //                 'assets/images/failure.png',
                                          //                 height: 150,
                                          //               ),
                                          //               kSmallHeight,
                                          //               Text(
                                          //                 'Failure',
                                          //                 style: redTextStyle.copyWith(
                                          //                     fontSize: 21),
                                          //               )
                                          //             ],
                                          //           ),
                                          //         ),
                                          //         onTap: () => failedQuiz(quiz));
                                          //   });
                                          // }
                                          // #FDE5E6
                                        },
                                  child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    decoration: BoxDecoration(
                                        border: indexNo == index
                                            ? Border.all(
                                                color: (selected ==
                                                        quizResult[quiz.number]
                                                            ['correctAnswer']
                                                    ? accentColor
                                                    : redColor))
                                            : Border.all(
                                                width: 0.2, color: greyColor),
                                        color: indexNo == index
                                            ? (selected ==
                                                    quizResult[quiz.number]
                                                        ['correctAnswer']
                                                ? secondaryColor
                                                : Color(0XFFFDE5E6))
                                            : Color(0XFFF9F9F9),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              children: [
                                                Container(
                                                  child: Text(
                                                    '${returnLetter(index + 1)}'
                                                        .toString(),
                                                    style: headingSmallGreyColor
                                                        .copyWith(
                                                            fontSize: 14,
                                                            color:
                                                                greyishColor),
                                                  ),
                                                  decoration: BoxDecoration(
                                                      color: greyColor2,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 12,
                                                      vertical: 6),
                                                ),
                                                SizedBox(
                                                  width: 30,
                                                ),
                                                Expanded(
                                                  child: SingleChildScrollView(
                                                    child: Text(
                                                      quizResult[quiz.number][
                                                          'option${index + 1}'],
                                                      style: textLightBlack
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              color: Color(
                                                                  0XFF747474)),
                                                      textAlign: TextAlign.left,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          quizResult[quiz.number]
                                                      ['explanation'] !=
                                                  null
                                              ? AnimatedCrossFade(
                                                  duration: Duration(
                                                      milliseconds: 1000),
                                                  firstCurve: Curves.easeOut,
                                                  secondCurve: Curves.easeIn,
                                                  sizeCurve: Curves.bounceOut,
                                                  crossFadeState: !show
                                                      ? CrossFadeState
                                                          .showSecond
                                                      : CrossFadeState
                                                          .showFirst,
                                                  firstChild: Container(),
                                                  secondChild: explanation(
                                                      selected: selected,
                                                      answer: quizResult[
                                                              quiz.number]
                                                          ['correctAnswer'],
                                                      index: index,
                                                      number: indexNo),
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        )
                      : Padding(
                          padding: defaultPadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Explanation',
                                style: headingSmallGreyColor.copyWith(
                                    color: greyishColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                              kSmallHeight,
                              Text(
                                quizResult[quiz.number]['explanation'],
                                style: headingSmallGreyColor.copyWith(
                                    fontSize: 16),
                              ),
                              kLargeHeight,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        show = !show;
                                      });
                                    },
                                    child: Text(
                                      'Back to options',
                                      style: smallPrimaryColor.copyWith(
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                  kSmallHeight,
                  AnimatedCrossFade(
                    duration: Duration(milliseconds: 1000),
                    firstCurve: Curves.easeOut,
                    secondCurve: Curves.easeIn,
                    sizeCurve: Curves.bounceOut,
                    crossFadeState: showBottomBar
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    firstChild: Container(),
                    secondChild: answerWidget(
                      selected: selected,
                      answer: quizResult[quiz.number]['correctAnswer'],
                      quiz: quiz,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ],
          ),
        );
      case 'gaps':
        return Column(
          children: [
            Padding(
              padding: defaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  kSmallHeight,
                  Column(
                    children: [
                      Image.asset(
                          quizResult[quiz.number]['resource']['image'][0]),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        quizResult[quiz.number]['resource']['description'][0],
                        style: textLightBlack.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.status ? whiteColor : blackColor),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 90,
                        child: GridView.builder(
                            itemCount: quizResult[quiz.number]['resource']
                                    ['questions']
                                ?.length,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: quizResult[quiz.number]
                                      ['resource']['questions']
                                  .length,
                              // childAspectRatio: 1,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 30,
                            ),
                            itemBuilder: (context, index) {
                              var quizType = quizData[quiz.number]['resource']
                                  ['questions'][index];
                              print('quizData:$quizData');

                              print('quizTyttype:$quizType');
                              print('quizTnumber:${quiz.number}');
                              print(
                                  'quizzzz:${quizResult[quiz.number]['resource']['questions']}');
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
                        height: 200,
                        child: GridView.builder(
                            itemCount: quizResult[quiz.number]['resource']
                                    ['options']
                                .length,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.6,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 30,
                            ),
                            itemBuilder: (context, index) {
                              var currentLength;

                              var quizName = quizResult[quiz.number]['resource']
                                  ['options'][index]['name'];
                              return InkWell(
                                onTap: () {
                                  setState(() {
                                    indexNo = index;
                                    selected = quizResult[quiz.number]
                                        ['resource']['options'][index]['name'];
                                    // expectedList(context);
                                    usersOption = [...usersOption, selected];
                                    currentLength = usersOption.length - 1;

                                    if (usersOption[currentLength]
                                            .toLowerCase() !=
                                        expectedValues[currentLength]['name']
                                            .toLowerCase()) {
                                      showBottomBar = !showBottomBar;
                                      showAnswerBox = 'fail';

                                      // Future.delayed(
                                      //     Duration(milliseconds: 700), () {

                                      // dialogBox(
                                      //     context,
                                      //     Container(
                                      //       height: 400,
                                      //       width:
                                      //           MediaQuery.of(context).size.width,
                                      //       child: Column(
                                      //         mainAxisAlignment:
                                      //             MainAxisAlignment.center,
                                      //         children: [
                                      //           Image.asset(
                                      //             'assets/images/failure.png',
                                      //             height: 150,
                                      //           ),
                                      //           kSmallHeight,
                                      //           Text(
                                      //             'Failure',
                                      //             style: redTextStyle.copyWith(
                                      //                 fontSize: 21),
                                      //           )
                                      //         ],
                                      //       ),
                                      //     ),
                                      //     onTap: () =>
                                      //         failedQuiz(quiz, gap: 'gap'));
                                      // });
                                    } else {
                                      print('quizdat:${quizData}');
                                      var data = quizData
                                          .map(
                                            (e) => {
                                              ...e['resource'],
                                              "questions": (e['resource']
                                                      ["questions"])
                                                  ?.map((f) => f["id"] ==
                                                          expectedValues[
                                                                  currentLength]
                                                              ["id"]
                                                      ? {...f, "active": true}
                                                      : f)
                                                  ?.toList()
                                            },
                                          )
                                          ?.first;
                                      print('dataaa:$data');
                                      quizData = quizData
                                          .map((e) => {...e, "resource": data})
                                          ?.toList();
                                      print('datquizDataaaa:$quizData');

                                      if (usersOption.length ==
                                          expectedValues.length) {
                                        showAnswerBox = 'pass';
                                        showBottomBar = !showBottomBar;

                                        print('number:${quiz.number}');

                                        // return answerBox(
                                        //     quiz: quiz,
                                        //     text: 'Correct!  You got 5 points',
                                        //     image: 'assets/images/smile.png',
                                        //     textColor: primaryColor,
                                        //     bgColor: secondaryColor,
                                        //     onTap: () {
                                        //       successfulQuiz(quiz, gap: 'gap');
                                        //       setState(() => click = !click);
                                        //     });
                                        // Future.delayed(Duration(milliseconds: 700),
                                        //     () {
                                        //   dialogBox(
                                        //       context,
                                        //       Container(
                                        //         height: 400,
                                        //         width: MediaQuery.of(context)
                                        //             .size
                                        //             .width,
                                        //         child: Column(
                                        //           children: [
                                        //             Image.asset(
                                        //               'assets/images/success.png',
                                        //             ),
                                        //             kSmallHeight,
                                        //             Text(
                                        //               'Success',
                                        //               style: smallPrimaryColor
                                        //                   .copyWith(fontSize: 21),
                                        //             )
                                        //           ],
                                        //         ),
                                        //       ),
                                        //       onTap: () =>
                                        //           successfulQuiz(quiz, gap: 'gap'));
                                        // });
                                      }
                                    }
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
                      ),
                    ],
                  )
                ],
              ),
            ),
            kSmallHeight,
            AnimatedCrossFade(
              duration: Duration(milliseconds: 1000),
              firstCurve: Curves.easeOut,
              secondCurve: Curves.easeIn,
              sizeCurve: Curves.bounceOut,
              crossFadeState: showBottomBar
                  ? CrossFadeState.showSecond
                  : CrossFadeState.showFirst,
              firstChild: Container(),
              secondChild: gapWidget(
                type: 'gap',
                quiz: quiz,
              ),
            )
            // click
            //     ? gapWidget(
            //         type: 'gap',
            //         quiz: quiz,
            //       )
            //     : Container()
          ],
        );
      default:
        return Container();
    }
  }

  String returnLetter(int number) {
    if (number == 1) {
      return 'A';
    } else if (number == 2) {
      return 'B';
    } else if (number == 3) {
      return 'C';
    } else if (number == 4) {
      return 'D';
    } else {
      return '';
    }
  }

  Widget quizScreen() {
    // Question Number
    QuizProvider quiz = QuizProvider.quizProvider(context);
    ThemeProvider theme = ThemeProvider.themeProvider(context);

    print('quizLenght: ${quizResult.length}');
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            kLargeHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextBox(
                  text: 'Take Quiz',
                ),
              ],
            ),
            kSmallHeight,
            Container(
              padding: defaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  kSmallHeight,
                  Container(
                    child: StepProgressIndicator(
                      totalSteps:
                          quizResult.length >= 10 ? 10 : quizResult.length,
                      currentStep: quiz.number + 1,
                      selectedColor: accentColor,
                      unselectedColor: theme.status ? whiteColor : greyColor2,
                      roundedEdges: Radius.circular(20),
                    ),
                  ),
                  kSmallHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                          onTap: () {
                            dialogBox(
                                context,
                                Container(
                                  padding: defaultPadding,
                                  height: 385,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // crossAxisAlignment:
                                    //     CrossAxisAlignment.stretch,
                                    children: [
                                      Image.asset('assets/images/caution.png'),
                                      kSmallHeight,
                                      Text(
                                        'Are you sure you want to end the quiz ',
                                        textAlign: TextAlign.center,
                                        style: smallAccentColor.copyWith(
                                            fontSize: 18),
                                      ),
                                      kSmallHeight,
                                      Text(
                                        'Kindly subscribe to take another quiz  ',
                                        textAlign: TextAlign.center,
                                        style: smallPrimaryColor.copyWith(
                                            fontSize: 15),
                                      ),
                                      kLargeHeight,
                                      GreenButton(
                                        name: 'Keep Playing',
                                        color: primaryColor,
                                        buttonColor: secondaryColor,
                                        loader: false,
                                        submit: () => Navigator.pop(context),
                                      ),
                                      kSmallHeight,
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          BorderButton(
                                            text: 'End',
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pushNamedAndRemoveUntil(
                                                      AppLayout.id,
                                                      (Route<dynamic> route) =>
                                                          false);
                                              quiz.setNumber(0);
                                            },
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                onTap: () => Navigator.pop(context));
                          },
                          child: Text(
                            'End Quiz',
                            style: smallPrimaryColor.copyWith(
                                decoration: TextDecoration.underline),
                          )),
                    ],
                  ),
                  kSmallHeight,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () => Navigator.pop(context),
                          child: Text('Question ${quiz.number + 1}',
                              style: smallAccentColor.copyWith(
                                  fontSize: 21, fontWeight: FontWeight.w600))),
                    ],
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
            getTestType(quizResult[quiz.number]['type']),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    print('subid: ${widget.subjectId}');

    futureQuiz = futureTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: FutureHelper<List<dynamic>>(
        task: futureQuiz,
        loader: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [circularProgressIndicator()],
        ),
        builder: (context, _) => quizResult.length == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  BackArrow(
                    text: 'No Quiz',
                  )
                ],
              )
            : quizScreen(),
      ),
    );
  }
}
