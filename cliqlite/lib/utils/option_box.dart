import 'package:cliqlite/models/mock_data/mock_data.dart';
import 'package:cliqlite/providers/quiz_provider/quiz_provider.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/material.dart';

class OptionBox extends StatefulWidget {
  OptionBox({this.number});
  final int number;

  @override
  _OptionBoxState createState() => _OptionBoxState();
}

class _OptionBoxState extends State<OptionBox> {
  int indexNo;
  String selected;

  @override
  Widget build(BuildContext context) {
    QuizProvider quiz = QuizProvider.quizProvider(context);
    print('quiz: ${quiz.number}');

    return Container(
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
                  selected = quizTypes[widget.number - 1]['option${index + 1}'];
                  if (selected ==
                      quizTypes[widget.number - 1]['correctAnswer']) {
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
                                style: smallPrimaryColor.copyWith(fontSize: 21),
                              )
                            ],
                          ),
                        ),
                        onTap: () => Navigator.pop(context));
                  } else {
                    dialogBox(
                        context,
                        Container(
                          height: 300,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/failure.png',
                                height: 150,
                              ),
                              kSmallHeight,
                              Text(
                                'Failure',
                                style: redTextStyle.copyWith(fontSize: 21),
                              )
                            ],
                          ),
                        ));
                  }
                  QuizProvider.quizProvider(context)
                      .setNumber(widget.number + 1);
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    border: indexNo == index
                        ? Border.all(color: primaryColor)
                        : Border.all(width: 0.2, color: greyColor),
                    color: indexNo == index ? primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                  child: Text(
                    quizTypes[QuizProvider.quizProvider(context).number - 1]
                        ['option${index + 1}'],
                    style: textLightBlack.copyWith(
                        fontWeight: FontWeight.w400,
                        color: indexNo == index ? secondaryColor : blackColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
