import 'package:cliqlite/models/notification_model/notification_model.dart';
import 'package:cliqlite/providers/notification_provider/notifction_provider.dart';
import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

enum Type { all, recent }

class _NotificationScreenState extends State<NotificationScreen> {
  Type type = Type.all;

  String val = 'All';

  Future<List<Notifications>> futureNotification;

  Future<List<Notifications>> futureTask() async {
    //Initialize provider
    NotificationProvider notify = NotificationProvider.notify(context);

    //Make call to get videos
    try {
      var result = await notify.getNotification();

      setState(() {});

      print('result:$result');

      //Return future value
      return Future.value(result);
    } catch (ex) {}
  }

  Widget notificationScreen() {
    List<Notifications> notificationList =
        NotificationProvider.notify(context).notification;
    // ThemeProvider theme = ThemeProvider.themeProvider(context);
    // AuthUser user = AuthProvider.auth(context).user;
    // ChildIndex childIndex = SubjectProvider.subject(context).index;
    // List<Users> users = AuthProvider.auth(context).users;
    // MainChildUser mainChildUser = AuthProvider.auth(context).mainChildUser;

    return SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BackArrow(
          text: 'Notifications',
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     BackArrow(
        //       text: 'Back to Home',
        //       onTap: () => Navigator.pop(context),
        //     ),
        //     // InkWell(
        //     //   onTap: () {
        //     //     if (user.role != 'user') {
        //     //       onTap(context);
        //     //     }
        //     //   },
        //     //   child: Container(
        //     //     decoration: BoxDecoration(
        //     //       borderRadius:
        //     //           new BorderRadius.all(const Radius.circular(10.0)),
        //     //       //color: Theme.of(context).backgroundColor,
        //     //     ),
        //     //     child: ClipRRect(
        //     //         borderRadius: BorderRadius.circular(10.0),
        //     //         child: CachedNetworkImage(
        //     //           imageUrl: users != null
        //     //               ? users[childIndex?.index ?? 0].photo
        //     //               : mainChildUser.photo,
        //     //           width: 35.0,
        //     //           height: 35.0,
        //     //           fit: BoxFit.cover,
        //     //         )),
        //     //   ),
        //     // ),
        //   ],
        // ),
        kSmallHeight,

        Container(
          padding: defaultPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  MenuTabs(
                    text: 'All',
                    groupVal: 'All',
                    value: val,
                    onTap: () {
                      setState(() {
                        val = 'All';
                      });
                    },
                  ),
                  kSmallWidth,
                  MenuTabs(
                    text: 'Recent',
                    groupVal: 'Recent',
                    value: val,
                    onTap: () {
                      setState(() {
                        val = 'Recent';
                      });
                    },
                  ),
                ],
              ),
              kSmallHeight,
              Container(
                height: MediaQuery.of(context).size.height * 0.75,
                child: ListView.builder(
                    itemCount: notificationList.length,
                    itemBuilder: (context, index) {
                      final support = notificationList[index];
                      return Column(
                        children: [
                          NotificationItems(
                            text: support.message,
                            date: DateFormat("d - MMM - y")
                                .format(support.createdAt)
                                .toString(),
                            time: DateFormat("h: mma")
                                .format(support.createdAt)
                                .toString(),
                          ),
                          kSmallHeight,
                        ],
                      );
                    }),
              )
            ],
          ),
        )
      ],
    ));
  }

  @override
  void initState() {
    futureNotification = futureTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        child: FutureHelper(
      task: futureNotification,
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
      builder: (context, _) => notificationScreen(),
    ));
  }
}

class MenuTabs extends StatelessWidget {
  const MenuTabs({
    Key key,
    this.text,
    this.value,
    this.groupVal,
    this.onTap,
  }) : super(key: key);
  final String text;
  final String value;
  final String groupVal;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: value == groupVal ? lighterPrimaryColor : lightGreyColor,
        ),
        child: Text(
          text,
          style: smallPrimaryColor.copyWith(
              color: value == groupVal ? accentColor : greyColor),
        ),
      ),
    );
  }
}

class NotificationItems extends StatelessWidget {
  const NotificationItems({
    Key key,
    this.text,
    this.date,
    this.time,
  });

  final String text;
  final String date;
  final String time;

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = ThemeProvider.themeProvider(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: smallPrimaryColor.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: accentColor),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Id vitae faucibus sit malesuada donec vel mi, vitae.',
              style: smallPrimaryColor,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              '$date  $time',
              style: smallPrimaryColor.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: accentColor),
            ),
          ],
        ),
        // Column(
        //   children: [
        //     Text(
        //       date,
        //       style: theme.status
        //           ? headingWhite.copyWith(fontSize: 12)
        //           : headingSmallGreyColor,
        //     ),
        //     SizedBox(
        //       height: 10,
        //     ),
        //     Text(
        //       time,
        //       style: theme.status
        //           ? headingWhite.copyWith(fontSize: 12)
        //           : headingSmallGreyColor,
        //     ),
        //   ],
        // ),
        kSmallHeight,
        Divider(
          color: greyColor,
          thickness: 0.2,
        )
      ],
    );
  }
}

class SubMenu extends StatelessWidget {
  const SubMenu({this.text, this.onTap, this.style, this.widget});

  final String text;
  final Function onTap;
  final TextStyle style;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Text(
            text,
            style: style,
          ),
          widget
        ],
      ),
    );
  }
}
