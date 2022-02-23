import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:flutter/material.dart';

class ViewDetails extends StatefulWidget {
  static String id = 'view-details';
  @override
  _ViewDetailsState createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BackArrow(
              text: 'Test Results',
            ),
            kSmallHeight,
            Padding(
                padding: defaultPadding,
                child: Column(
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: ListView.separated(
                        itemBuilder: (context, index) => ViewItems(),
                        separatorBuilder: (context, _) => SizedBox(
                          height: 10,
                        ),
                        itemCount: 15,
                        shrinkWrap: true,
                        // physics: NeverScrollableScrollPhysics(),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class ViewItems extends StatelessWidget {
  const ViewItems({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Quiz 1 (Q1)',
                    style: smallPrimaryColor.copyWith(
                        color: accentColor, fontSize: 16)),
                kVerySmallHeight,
                Text('50%  |  25/50',
                    style: headingSmallGreyColor.copyWith(fontSize: 14)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('English Language',
                    style: headingSmallGreyColor.copyWith(fontSize: 14)),
                kVerySmallHeight,
                Text('Adjectives and pronouns',
                    style: headingSmallGreyColor.copyWith(fontSize: 14)),
              ],
            ),
          ],
        ),
        kSmallHeight,
        Divider(
          thickness: 1,
        )
      ],
    );
  }
}
