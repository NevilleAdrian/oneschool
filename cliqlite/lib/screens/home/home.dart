import 'package:cliqlite/models/mock_data/mock_data.dart';
import 'package:cliqlite/providers/child_provider/child_provider.dart';
import 'package:cliqlite/screens/auth/child_registration.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/home/notifications.dart';
import 'package:cliqlite/screens/search_screen/search_screen.dart';
import 'package:cliqlite/screens/subject_screen/subject_screen.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/dialog_box.dart';
import 'package:cliqlite/utils/outline_button.dart';
import 'package:cliqlite/utils/search_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  static String id = "home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> children = ChildProvider.childProvider(context).children;
    return BackgroundImage(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              overflow: Overflow.visible,
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  padding:
                      EdgeInsets.only(top: 70, bottom: 20, left: 20, right: 20),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40),
                      )),
                  height: 230,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Hello Aanu',
                              style: headingWhite.copyWith(fontSize: 24)),
                          SizedBox(
                            height: 15,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width / 1.8,
                            child: Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. ',
                              style: headingWhite18.copyWith(fontSize: 18),
                              textAlign: TextAlign.start,
                              // overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Notifications())),
                            child: SvgPicture.asset(
                              'assets/images/svg/bell.svg',
                            ),
                          ),
                          kSmallWidth,
                          InkWell(
                            onTap: () => onTap(context),
                            child: Image.asset(
                              'assets/images/picture.png',
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Positioned(
                    bottom: -22,
                    child: InkWell(
                      onTap: () =>
                          Navigator.pushNamed(context, SearchScreen.id),
                      child: SearchBox(
                        type: 'route',
                      ),
                    )),
              ],
            ),
            kLargeHeight,
            Column(
              children: [
                Container(
                  padding: defaultPadding.copyWith(right: 0),
                  child: GroupedWidgets(
                    data: data,
                    text: "Subjects based on${children[0]['name']}'s class",
                  ),
                ),
                Container(
                  padding: defaultPadding.copyWith(right: 0),
                  child: GroupedWidgets(
                    data: data,
                    text: 'Popular Subjects',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DialogBody extends StatelessWidget {
  const DialogBody({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    List<dynamic> children = ChildProvider.childProvider(context).children;
    return Container(
      height: 280,
      width: MediaQuery.of(context).size.width * 2,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Manage Users',
                textAlign: TextAlign.center,
                style: textStyleSmall.copyWith(
                    fontSize: 21.0,
                    fontWeight: FontWeight.w700,
                    color: primaryColor),
              ),
              kLargeHeight,
              children.isNotEmpty
                  ? Container(
                      height: 90,
                      // width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                          separatorBuilder: (context, int) => kSmallWidth,
                          scrollDirection: Axis.horizontal,
                          itemCount: children.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Image.asset(
                                      children[index]['image_url'],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    toBeginningOfSentenceCase(
                                        children[index]['name']),
                                    style:
                                        textLightBlack.copyWith(fontSize: 12),
                                  )
                                ],
                              ),
                            );
                          }),
                    )
                  : Text(
                      'You do not have any child added yet',
                      textAlign: TextAlign.center,
                      style: textStyleSmall.copyWith(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w700,
                          color: blackColor),
                    ),
              kSmallHeight,
              LineButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ChildRegistration(
                              user: 'child',
                            ))),
                text: 'Add a Child',
              )
            ],
          ),
        ),
      ),
    );
  }
}

class GroupedWidgets extends StatelessWidget {
  const GroupedWidgets({@required this.data, this.text, this.onPressed});

  final List<Map<String, String>> data;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    onTap(String name) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SubjectScreen(
                    text: name,
                    route: 'home',
                  )));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: heading18Black,
        ),
        kSmallHeight,
        Container(
          height: 160,
          child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                    width: 10,
                  ),
              scrollDirection: Axis.horizontal,
              itemCount: data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    InkWell(
                      onTap: onPressed ?? () => onTap(data[index]['name']),
                      child: Image.asset(
                        data[index]['image'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data[index]['name'],
                            style: headingWhite.copyWith(fontSize: 13),
                          )
                        ],
                      ),
                      bottom: 60,
                      right: 0,
                      left: 0,
                    )
                  ],
                );
              }),
        )
      ],
    );
  }
}
