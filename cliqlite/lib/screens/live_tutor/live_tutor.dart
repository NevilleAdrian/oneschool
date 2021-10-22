import 'package:cliqlite/models/mock_data/mock_data.dart';
import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/home/notifications.dart';
import 'package:cliqlite/screens/search_screen/search_screen.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/dialog_box.dart';
import 'package:cliqlite/utils/search_box.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:indexed/indexed.dart';

class LiveTutor extends StatefulWidget {
  @override
  _LiveTutorState createState() => _LiveTutorState();
}

enum Type { all, subject, online, scheduled }

class _LiveTutorState extends State<LiveTutor> {
  Type type = Type.all;
  bool show = false;

  DateTime selectedDate;

  onPressed() {
    dialogBox(
        context,
        Container(
          height: 300,
          child: CalendarCarousel(
            onDayPressed: (DateTime date, List<Event> events) {
              this.setState(() => selectedDate = date);
            },
            weekendTextStyle: TextStyle(
              color: primaryColor,
            ),
            weekFormat: false,
            height: 420.0,
            selectedDateTime: selectedDate,
            daysHaveCircularBorder: false,
            selectedDayTextStyle: smallPrimaryColor,
            headerTextStyle: smallPrimaryColor.copyWith(fontSize: 20),
            iconColor: primaryColor,
            weekdayTextStyle: textExtraLightBlack.copyWith(fontSize: 12),
            // dayButtonColor: primaryColor,
            // thisMonthDayBorderColor: primaryColor,
          ),
        ),
        onTap: () => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = ThemeProvider.themeProvider(context);

    return InkWell(
      onTap: () {
        setState(() {
          show = false;
        });
      },
      child: BackgroundImage(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: defaultVHPadding,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tutors',
                            textAlign: TextAlign.center,
                            style: textStyleSmall.copyWith(
                                fontSize: 21.0,
                                fontWeight: FontWeight.w700,
                                color: theme.status
                                    ? secondaryColor
                                    : primaryColor),
                          ),
                          InkWell(
                            onTap: () => onTap(context),
                            child: Image.asset(
                              'assets/images/picture.png',
                            ),
                          )
                        ],
                      ),
                      kLargeHeight,
                      Row(
                        children: [
                          SubMenu(
                            text: 'All',
                            onTap: () {
                              setState(() => type = Type.all);
                            },
                            style: type == Type.all
                                ? heading18Black.copyWith(fontSize: 16)
                                : headingGrey.copyWith(
                                    color: greyColor, fontSize: 16),
                            widget: type == Type.all
                                ? SvgPicture.asset(
                                    'assets/images/svg/circle.svg')
                                : Container(
                                    height: 7,
                                  ),
                          ),
                          kSmallWidth,
                          SubMenu(
                            text: 'Per Subject',
                            onTap: () {
                              setState(() => type = Type.subject);
                            },
                            style: type == Type.subject
                                ? heading18Black.copyWith(fontSize: 16)
                                : headingGrey.copyWith(
                                    color: greyColor, fontSize: 16),
                            widget: type == Type.subject
                                ? SvgPicture.asset(
                                    'assets/images/svg/circle.svg')
                                : Container(
                                    height: 7,
                                  ),
                          ),
                          kSmallWidth,
                          SubMenu(
                            text: 'Online',
                            onTap: () {
                              setState(() => type = Type.online);
                            },
                            style: type == Type.online
                                ? heading18Black.copyWith(fontSize: 16)
                                : headingGrey.copyWith(
                                    color: greyColor, fontSize: 16),
                            widget: type == Type.online
                                ? SvgPicture.asset(
                                    'assets/images/svg/circle.svg')
                                : Container(
                                    height: 7,
                                  ),
                          ),
                          kSmallWidth,
                          SubMenu(
                            text: 'Scheduled',
                            onTap: () {
                              setState(() => type = Type.scheduled);
                            },
                            style: type == Type.scheduled
                                ? heading18Black.copyWith(fontSize: 16)
                                : headingGrey.copyWith(
                                    color: greyColor, fontSize: 16),
                            widget: type == Type.scheduled
                                ? SvgPicture.asset(
                                    'assets/images/svg/circle.svg')
                                : Container(
                                    height: 7,
                                  ),
                          ),
                        ],
                      ),
                      kLargeHeight,
                      InkWell(
                        onTap: () =>
                            Navigator.pushNamed(context, SearchScreen.id),
                        child: SearchBox(
                          type: 'route',
                          padding: EdgeInsets.zero,
                          placeholder: 'Search for Subject or Tutor',
                        ),
                      ),
                    ],
                  ),
                ),
                kSmallHeight,
                Padding(
                  padding: defaultPadding,
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        show = !show;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Maths',
                          style: textExtraLightBlack.copyWith(fontSize: 18),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: blackColor,
                        )
                      ],
                    ),
                  ),
                ),
                kSmallHeight,
                Padding(
                  padding: defaultPadding,
                  child: Indexer(
                    children: [
                      Indexed(
                        index: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            show
                                ? Positioned(
                                    bottom: -190,
                                    child: Material(
                                      elevation: 1,
                                      borderRadius: BorderRadius.circular(30.0),
                                      color: Colors.white,
                                      shadowColor: Colors.black,
                                      child: Container(
                                        padding: defaultVHPadding.copyWith(
                                            top: 20, bottom: 20),
                                        width: 200,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text('Maths'),
                                            kSmallHeight,
                                            Text('English'),
                                            kSmallHeight,
                                            Text('Chemistry'),
                                          ],
                                        ),
                                      ),
                                    ))
                                : Container(),
                          ],
                        ),
                      ),
                      kSmallHeight,
                      Container(
                        height: MediaQuery.of(context).size.height,
                        child: ListView.separated(
                            separatorBuilder: (context, int) => kSmallHeight,
                            itemCount: tutorData.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => InkWell(
                                  onTap: () => onPressed(),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                                tutorData[index]['image']),
                                            kSmallWidth,
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  tutorData[index]['name'],
                                                  style: textLightBlack,
                                                ),
                                                kSmallHeight,
                                                Text(
                                                  tutorData[index]['subject'],
                                                  style: textExtraLightBlack,
                                                ),
                                                kSmallHeight,
                                                Text(
                                                  tutorData[index]['online']
                                                      ? 'Online'
                                                      : 'Offline',
                                                  style: textExtraLightBlack,
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            tutorData[index]['online']
                                                ? SvgPicture.asset(
                                                    'assets/images/svg/tutor-circle.svg')
                                                : Container()
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
