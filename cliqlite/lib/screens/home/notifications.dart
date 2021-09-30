import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

enum Type { all, recent }

class _NotificationsState extends State<Notifications> {
  Type type = Type.all;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: defaultVHPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackArrow(
                  text: 'Back to Home',
                  onTap: () => Navigator.pop(context),
                ),
                Image.asset(
                  'assets/images/picture.png',
                ),
              ],
            ),
            kLargeHeight,
            Text(
              'Notifications',
              textAlign: TextAlign.center,
              style: textStyleSmall.copyWith(
                  fontSize: 21.0,
                  fontWeight: FontWeight.w700,
                  color: primaryColor),
            ),
            kSmallHeight,
            Row(
              children: [
                SubMenu(
                  text: 'All',
                  onTap: () {
                    setState(() => type = Type.all);
                  },
                  style: type == Type.all
                      ? heading18Black.copyWith(fontSize: 16)
                      : headingGrey.copyWith(color: greyColor, fontSize: 16),
                  widget: type == Type.all
                      ? SvgPicture.asset('assets/images/svg/circle.svg')
                      : Container(
                          height: 7,
                        ),
                ),
                kLargeWidth,
                SubMenu(
                  text: 'Recent',
                  onTap: () {
                    setState(() => type = Type.recent);
                  },
                  style: type == Type.recent
                      ? heading18Black.copyWith(fontSize: 16)
                      : headingGrey.copyWith(color: greyColor, fontSize: 16),
                  widget: type == Type.recent
                      ? SvgPicture.asset('assets/images/svg/circle.svg')
                      : Container(
                          height: 7,
                        ),
                ),
              ],
            ),
            kLargeHeight,
            Expanded(
              child: ListView(
                children: [
                  NotificationItems(
                    text: 'Lorem ipsum tutor is live',
                  ),
                  kSmallHeight,
                  NotificationItems(
                    text: 'New Writing Videos Added',
                  ),
                  kSmallHeight,
                  NotificationItems(
                    text: 'New Writing Videos Added',
                  ),
                  kSmallHeight,
                  NotificationItems(
                    text: 'New Writing Videos Added',
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

class NotificationItems extends StatelessWidget {
  const NotificationItems({
    Key key,
    this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  text,
                  style: heading18Black.copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  'Join here',
                  style: headingPrimaryColor.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  '8th Sept',
                  style: headingSmallGreyColor,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '4pm',
                  style: headingSmallGreyColor,
                ),
              ],
            )
          ],
        ),
        kSmallHeight,
        Divider(
          color: greyColor,
          thickness: 0.6,
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
