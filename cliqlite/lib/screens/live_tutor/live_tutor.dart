import 'package:cliqlite/models/livestream_model/livestream_model.dart';
import 'package:cliqlite/models/mock_data/mock_data.dart';
import 'package:cliqlite/providers/livestream_provider/livestream_provider.dart';
import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/home/home.dart';
import 'package:cliqlite/screens/home/notifications.dart';
import 'package:cliqlite/screens/live_tutor/live_video.dart';
import 'package:cliqlite/screens/videos/videos.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';

class LiveTutor extends StatefulWidget {
  @override
  _LiveTutorState createState() => _LiveTutorState();
}

enum Type { all, subject, online, scheduled }

class _LiveTutorState extends State<LiveTutor> {
  Type type = Type.all;

  String val = 'All';

  Future<List<LiveStream>> futureLiveStream;

  Future<List<LiveStream>> futureTask() async {
    //Initialize provider
    LiveStreamProvider live = LiveStreamProvider.liveStream(context);

    //Make call to get videos
    try {
      var result = await live.getLiveStream();

      setState(() {});

      print('result:$result');

      //Return future value
      return Future.value(result);
    } catch (ex) {}
  }

  bool show = false;

  DateTime selectedDate;

  onPressed({DateTime startDate, DateTime endDate}) {
    dialogBox(
        context,
        Container(
          height: 320,
          width: 300,
          child: CalendarCarousel(
            onDayPressed: (DateTime date, List<Event> events) {
              this.setState(() => selectedDate = date);
            },
            weekendTextStyle: TextStyle(
              color: primaryColor,
            ),
            weekFormat: false,
            height: 420.0,
            selectedDateTime: startDate,
            targetDateTime: endDate,
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

  onLive({String url}) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => VideoApp(
                  url: url,
                )));
  }

  String selectPicture(String picture) {
    if (picture == 'no-photo.jpg') {
      return tutorData[0]['image'];
    } else {
      return picture;
    }
  }

  Widget live() {
    ThemeProvider theme = ThemeProvider.themeProvider(context);
    List<LiveStream> liveList = LiveStreamProvider.liveStream(context).live;
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            BackArrow(
              text: 'Live Tutor',
            ),
            Padding(
              padding: defaultPadding,
              child: Column(
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Tutors',
                  //       textAlign: TextAlign.center,
                  //       style: textStyleSmall.copyWith(
                  //           fontSize: 21.0,
                  //           fontWeight: FontWeight.w700,
                  //           color:
                  //               theme.status ? secondaryColor : primaryColor),
                  //     ),
                  //     profilePicture(context)
                  //   ],
                  // ),

                  kSmallHeight,
                  Container(
                    height: 40,
                    child: ListView.separated(
                      separatorBuilder: (context, _) => kSmallWidth,
                      itemCount: liveData.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        String name = liveData[index]['name'];
                        return MenuTabs(
                          text: name,
                          groupVal: name,
                          value: val,
                          onTap: () {
                            setState(() {
                              val = name;
                            });
                          },
                        );
                      },
                    ),
                  ),

                  // Row(
                  //   children: [
                  //     SubMenu(
                  //       text: 'All',
                  //       onTap: () {
                  //         setState(() => type = Type.all);
                  //       },
                  //       style: type == Type.all
                  //           ? heading18Black.copyWith(fontSize: 16)
                  //           : headingGrey.copyWith(
                  //               color: greyColor, fontSize: 16),
                  //       widget: type == Type.all
                  //           ? SvgPicture.asset(
                  //               'assets/images/svg/circle.svg')
                  //           : Container(
                  //               height: 7,
                  //             ),
                  //     ),
                  //     kSmallWidth,
                  //     SubMenu(
                  //       text: 'Per Subject',
                  //       onTap: () {
                  //         setState(() => type = Type.subject);
                  //       },
                  //       style: type == Type.subject
                  //           ? heading18Black.copyWith(fontSize: 16)
                  //           : headingGrey.copyWith(
                  //               color: greyColor, fontSize: 16),
                  //       widget: type == Type.subject
                  //           ? SvgPicture.asset(
                  //               'assets/images/svg/circle.svg')
                  //           : Container(
                  //               height: 7,
                  //             ),
                  //     ),
                  //     kSmallWidth,
                  //     SubMenu(
                  //       text: 'Online',
                  //       onTap: () {
                  //         setState(() => type = Type.online);
                  //       },
                  //       style: type == Type.online
                  //           ? heading18Black.copyWith(fontSize: 16)
                  //           : headingGrey.copyWith(
                  //               color: greyColor, fontSize: 16),
                  //       widget: type == Type.online
                  //           ? SvgPicture.asset(
                  //               'assets/images/svg/circle.svg')
                  //           : Container(
                  //               height: 7,
                  //             ),
                  //     ),
                  //     kSmallWidth,
                  //     SubMenu(
                  //       text: 'Scheduled',
                  //       onTap: () {
                  //         setState(() => type = Type.scheduled);
                  //       },
                  //       style: type == Type.scheduled
                  //           ? heading18Black.copyWith(fontSize: 16)
                  //           : headingGrey.copyWith(
                  //               color: greyColor, fontSize: 16),
                  //       widget: type == Type.scheduled
                  //           ? SvgPicture.asset(
                  //               'assets/images/svg/circle.svg')
                  //           : Container(
                  //               height: 7,
                  //             ),
                  //     ),
                  //   ],
                  // ),
                  // kLargeHeight,
                  // InkWell(
                  //   onTap: () =>
                  //       Navigator.pushNamed(context, SearchScreen.id),
                  //   child: SearchBox(
                  //     type: 'route',
                  //     padding: EdgeInsets.zero,
                  //     placeholder: 'Search for Subject or Tutor',
                  //   ),
                  // ),
                ],
              ),
            ),
            kSmallHeight,
            Divider(
              thickness: 3,
            ),
            kSmallHeight,
            Padding(
              padding: defaultPadding,
              child: Column(
                children: [
                  SearchCard(),
                  kLargeHeight,
                  Container(
                    child: ListView.separated(
                        separatorBuilder: (context, _) => kSmallHeight,
                        itemCount: 4,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return SwipeItems(
                            widget: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    child: SwipeChild(
                                      height: 150,
                                      widget: YellowButton(
                                        text: 'Join Session',
                                      ),
                                    ),
                                    onTap: () => Navigator.pushNamed(
                                        context, VideoApp.id))
                              ],
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),

            // kSmallHeight,
            // Padding(
            //   padding: defaultPadding,
            //   child: InkWell(
            //     onTap: () {
            //       setState(() {
            //         show = !show;
            //       });
            //     },
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.start,
            //       children: [
            //         Text(
            //           'Maths',
            //           style: textExtraLightBlack.copyWith(fontSize: 18),
            //         ),
            //         SizedBox(
            //           width: 5,
            //         ),
            //         Icon(
            //           Icons.keyboard_arrow_down,
            //           color: blackColor,
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // kSmallHeight,
            // liveList.isEmpty
            //     ? Column(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text(
            //             'No data available',
            //           )
            //         ],
            //       )
            //     : Padding(
            //         padding: defaultPadding,
            //         child: Indexer(
            //           children: [
            //             Indexed(
            //               index: 3,
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.start,
            //                 children: [
            //                   show
            //                       ? Positioned(
            //                           bottom: -190,
            //                           child: Material(
            //                             elevation: 1,
            //                             borderRadius:
            //                                 BorderRadius.circular(30.0),
            //                             color: Colors.white,
            //                             shadowColor: Colors.black,
            //                             child: Container(
            //                               padding: defaultVHPadding.copyWith(
            //                                   top: 20, bottom: 20),
            //                               width: 200,
            //                               child: Column(
            //                                 crossAxisAlignment:
            //                                     CrossAxisAlignment.start,
            //                                 children: [
            //                                   Text('Maths'),
            //                                   kSmallHeight,
            //                                   Text('English'),
            //                                   kSmallHeight,
            //                                   Text('Chemistry'),
            //                                 ],
            //                               ),
            //                             ),
            //                           ))
            //                       : Container(),
            //                 ],
            //               ),
            //             ),
            //             kSmallHeight,
            //             Container(
            //               height: MediaQuery.of(context).size.height,
            //               child: ListView.separated(
            //                   separatorBuilder: (context, int) => kSmallHeight,
            //                   itemCount: liveList.length,
            //                   physics: NeverScrollableScrollPhysics(),
            //                   itemBuilder: (context, index) => InkWell(
            //                         onTap: () => liveList[index].tutor.isOnline
            //                             ? onLive(
            //                                 url: liveList[index].broadcastUrl)
            //                             : onPressed(
            //                                 startDate: liveList[index]
            //                                     .appointment
            //                                     .start,
            //                                 endDate: liveList[index]
            //                                     .appointment
            //                                     .end),
            //                         child: Container(
            //                           padding: EdgeInsets.symmetric(
            //                               vertical: 10, horizontal: 10),
            //                           color: Colors.white,
            //                           child: Row(
            //                             mainAxisAlignment:
            //                                 MainAxisAlignment.spaceBetween,
            //                             children: [
            //                               Row(
            //                                 children: [
            //                                   Image.asset(selectPicture(
            //                                       liveList[index].tutor.photo)),
            //                                   kSmallWidth,
            //                                   Column(
            //                                     crossAxisAlignment:
            //                                         CrossAxisAlignment.start,
            //                                     children: [
            //                                       Text(
            //                                         liveList[index]
            //                                             .tutor
            //                                             .fullname,
            //                                         style: textLightBlack,
            //                                       ),
            //                                       kSmallHeight,
            //                                       Text(
            //                                         liveList[index]
            //                                             .subject
            //                                             .name,
            //                                         style: textExtraLightBlack,
            //                                       ),
            //                                       kSmallHeight,
            //                                       Text(
            //                                         liveList[index]
            //                                                 .tutor
            //                                                 .isOnline
            //                                             ? 'Online'
            //                                             : 'Offline',
            //                                         style: textExtraLightBlack,
            //                                       ),
            //                                     ],
            //                                   )
            //                                 ],
            //                               ),
            //                               Column(
            //                                 mainAxisAlignment:
            //                                     MainAxisAlignment.start,
            //                                 children: [
            //                                   liveList[index].tutor.isOnline
            //                                       ? SvgPicture.asset(
            //                                           'assets/images/svg/tutor-circle.svg')
            //                                       : Container()
            //                                 ],
            //                               )
            //                             ],
            //                           ),
            //                         ),
            //                       )),
            //             )
            //           ],
            //         ),
            //       ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    futureLiveStream = futureTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    LiveStreamProvider liveProvider = LiveStreamProvider.liveStream(context);
    return InkWell(
      onTap: () {
        setState(() {
          show = false;
        });
      },
      child: BackgroundImage(
          child: FutureHelper(
        task: futureLiveStream,
        loader: liveProvider?.live == null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [circularProgressIndicator()],
              )
            : live(),
        noData: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('No data available')],
        ),
        builder: (context, _) => live(),
      )),
    );
  }
}
