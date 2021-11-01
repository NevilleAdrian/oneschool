import 'package:cliqlite/models/support_model/support_model.dart';
import 'package:cliqlite/providers/support_provider/support_provider.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Support extends StatefulWidget {
  static String id = 'support';
  @override
  _SupportState createState() => _SupportState();
}

class _SupportState extends State<Support> {
  Future<List<SupportModel>> futureSupport;

  Future<List<SupportModel>> futureTask() async {
    //Initialize provider
    SupportProvider support = SupportProvider.support(context);

    //Make call to get videos
    try {
      var result = await support.getSupport();

      setState(() {});

      print('result:$result');

      //Return future value
      return Future.value(result);
    } catch (ex) {}
  }

  @override
  void initState() {
    futureSupport = futureTask();
    super.initState();
  }

  Widget supportScreen() {
    List<SupportModel> supportList =
        SupportProvider.support(context).supportList;
    return SafeArea(
      child: Padding(
        padding: defaultVHPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.chevron_left,
                      color: blackColor,
                    )),
                Text(
                  "Support",
                  textAlign: TextAlign.center,
                  style: textStyleSmall.copyWith(
                      fontSize: 21.0,
                      fontWeight: FontWeight.w700,
                      color: primaryColor),
                ),
                Container()
              ],
            ),
            kSmallHeight,
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Got any questions? Find',
                  style: textExtraLightBlack.copyWith(fontSize: 18),
                ),
                Text(
                  'all answers here!',
                  style: textExtraLightBlack.copyWith(fontSize: 18),
                )
              ],
            ),
            kLargeHeight,
            Expanded(
              child: ListView.builder(
                  itemCount: supportList.length,
                  itemBuilder: (context, index) {
                    final support = supportList[index];
                    return Column(
                      children: [
                        ExpandablePanel(
                          header: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              toBeginningOfSentenceCase(support.question) ?? '',
                              style: textExtraLightBlack.copyWith(fontSize: 18),
                            ),
                          ),
                          collapsed: Text(
                            ' ',
                          ),
                          expanded: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              toBeginningOfSentenceCase(support.answer) ?? '',
                              style: textExtraLightBlack.copyWith(fontSize: 18),
                              softWrap: true,
                            ),
                          ),
                        ),
                        Divider(
                          height: 20,
                          thickness: 0.9,
                          color: greyColor,
                        )
                      ],
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: FutureHelper(
        task: futureSupport,
        loader: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [circularProgressIndicator()],
        ),
        noData: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('No data available')],
        ),
        builder: (context, _) => supportScreen(),
      ),
    );
  }
}
