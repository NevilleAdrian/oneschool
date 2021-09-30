import 'package:cliqlite/models/mock_data/mock_data.dart';
import 'package:cliqlite/providers/quiz_provider/quiz_provider.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/option_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class QuizTypes extends StatelessWidget {
  QuizTypes({this.number, this.type});
  final int number;
  final String type;
  @override
  Widget build(BuildContext context) {
    int number = QuizProvider.quizProvider(context).number;
    print('numberzzz:$number');
    return getTestType(type);
  }

  //Quiz type generator
  Widget getTestType(String type) {
    switch (type) {
      case 'optionType':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(quizTypes[number - 1]['image']),
            SizedBox(
              height: 40,
            ),
            Text(
              quizTypes[number - 1]['description'],
              style: textLightBlack.copyWith(fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 40,
            ),
            OptionBox(
              number: number,
            )
          ],
        );
      case 'completeType':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(quizTypes[number - 1]['image']),
            kSmallHeight,
            Text('Complete Type')
          ],
        );
      default:
        return Container();
    }
  }
}
