import 'package:cliqlite/models/auth_model/main_auth_user/main_auth_user.dart';
import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
import 'package:cliqlite/models/feedback/feedback.dart';
import 'package:cliqlite/models/grades/grades.dart';
import 'package:cliqlite/models/quiz_active/quiz_active.dart';
import 'package:cliqlite/models/recent_topics/recent_topics.dart';
import 'package:cliqlite/models/subject/subject.dart';
import 'package:cliqlite/models/users_model/users.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/notification_provider/notifction_provider.dart';
import 'package:cliqlite/providers/quiz_provider/quiz_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/providers/topic_provider/topic_provider.dart';
import 'package:cliqlite/repository/hive_repository.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/auth/login.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/home/notifications.dart';
import 'package:cliqlite/screens/home/profile_body.dart';
import 'package:cliqlite/screens/quiz_screen/quiz_screen.dart';
import 'package:cliqlite/screens/search_screen/search_screen.dart';
import 'package:cliqlite/screens/videos/video_fulls_screen.dart';
import 'package:cliqlite/screens/videos/video_lessons.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/constants.dart';
import 'package:cliqlite/utils/home_tabs.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/search_box.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:cliqlite/utils/text_box.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:indexed/indexed.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:share/share.dart';

class Home extends StatefulWidget {
  static String id = "home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<List<Subject>> futureSubjects;
  Future<List<Users>> futureUsers;
  var childUser;
  HiveRepository _hiveRepository = HiveRepository();

  Future<List<Subject>> futureTask() async {
    //Initialize provider
    SubjectProvider subject = SubjectProvider.subject(context);
    AuthProvider auth = AuthProvider.auth(context);
    NotificationProvider notify = NotificationProvider.notify(context);
    QuizActive quizActive = QuizProvider.quizProvider(context).quizActive;
    TopicProvider topic = TopicProvider.topic(context);
    ChildIndex childIndex = subject.index;

    //Make call to get grades
    await auth.getGrades();

    //Make call to get feedbacks
    await notify.getFeedBack();

    List<Users> data;
    List<Subject> sub;

    //Make call to get child
    if (auth.user.role != 'child') {
      // // Make call to get Children
      data = await AuthProvider.auth(context).getChildren();

      print('gradee:: ${auth.users}');
      // // Make call to get Subjects
      sub = await subject.getSubjects(
        id: subject?.grade?.grade ?? auth.users[0].grade,
        name: subject?.grade?.name ?? auth.users[0].name,
      );

      // Make call to get Recent topics
      await topic.getRecentTopics(
          childId:
              AuthProvider.auth(context).users[childIndex?.index ?? 0]?.id);

      //check if subscription is active
      // if (AuthProvider.auth(context).users[childIndex?.index ?? 0].isActive &&
      //     quizActive.active) {
      //   onPressed();
      // }

    } else {
      //Get Child
      AuthProvider.auth(context).mainChildUser;
      childUser = await AuthProvider.auth(context).getMainChild();

      if (childUser != null) {
        //Make call to get Recent topics
        await topic.getRecentTopics(
          childId: AuthProvider.auth(context).mainChildUser?.id,
        );

        //check if subscription is active
        // if (AuthProvider.auth(context).mainChildUser.isActive &&
        //     quizActive.active) {
        //   onPressed();
        // }

        //Make call to get subjects
        sub = await subject.getSubjects(
          id: auth.user.grade,
          name: auth.user.fullname,
        );
      }
    }
    setState(() {
      if (sub != null) {
        subject.setSpinner(false);
      }
    });

    //Return future value
    return Future.value(sub);
  }

  List<Grades> grades;
  String val = 'grade 1';

  shareToSocials(BuildContext context) async {
    final RenderBox box = context.findRenderObject();
    await Share.share("Hi friend please join Cliqlite with this link",
        subject: "Invitation to join app",
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }

  Widget dialogContent(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setModalState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                width: 300,
                child: ListView.separated(
                  separatorBuilder: (context, _) => SizedBox(
                    height: 10,
                  ),
                  itemCount: grades.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return HomeTabs(
                      text: toBeginningOfSentenceCase(grades[index].name),
                      attribute: grades[index].name,
                      onChanged: () {
                        setModalState(() => val = grades[index].name ?? '');
                        setState(() {});
                        print('val:$val');
                      },
                      groupVal: val,
                    );
                  },
                ),
              ),
            ),
            GreenButton(
              submit: () => nextPage(),
              color: primaryColor,
              name: 'Continue',
              buttonColor: secondaryColor,
              loader: false,
            ),
          ],
        );
      },
    );
  }

  Widget home({List<Users> children}) {
    List<Subject> subject = SubjectProvider.subject(context).subjects;
    List<Feedbacks> feed = NotificationProvider.notify(context).feedback;
    List<RecentTopic> childTopics = TopicProvider.topic(context).recentTopics;
    ChildIndex childIndex = SubjectProvider.subject(context).index;
    List<Users> users = AuthProvider.auth(context).users;
    MainChildUser mainChildUser = AuthProvider.auth(context).mainChildUser;
    grades = AuthProvider.auth(context).grades;

    return ModalProgressHUD(
      inAsyncCall: SubjectProvider.subject(context).spinner,
      progressIndicator: CircularProgressIndicator(
        strokeWidth: 7,
        valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
      ),
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
                      color: accentColor,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                      )),
                  height: 260,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Welcome',
                                      style:
                                          headingWhite.copyWith(fontSize: 24),
                                    ),
                                    // Container(
                                    //   width: MediaQuery.of(context).size.width / 2,
                                    //   child: Text(
                                    //     ' ${toBeginningOfSentenceCase(users != null ? users[childIndex?.index ?? 0].name.split(' ')[0] : mainChildUser.name.split(' ')[0])}',
                                    //     style: headingWhite.copyWith(fontSize: 24),
                                    //     overflow: TextOverflow.ellipsis,
                                    //     maxLines: 1,
                                    //     softWrap: false,
                                    //   ),
                                    // ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Image.asset('assets/images/wave.png')
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.8,
                                  child: Text(
                                    "Let's start learning",
                                    style:
                                        headingWhite18.copyWith(fontSize: 18),
                                    textAlign: TextAlign.start,
                                    // overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              // InkWell(
                              //   onTap: () {
                              //     dialogBox(
                              //       context,
                              //       dialogContent(context),
                              //       top: AppBar(
                              //         backgroundColor: Colors.white,
                              //         elevation: 0,
                              //         title: Text(
                              //           'Choose a class',
                              //           style: smallPrimaryColor.copyWith(
                              //               fontSize: 16,
                              //               fontWeight: FontWeight.w600),
                              //         ),
                              //         actions: [
                              //           XButton(
                              //             onTap: () => Navigator.pop(context),
                              //             color: primaryColor,
                              //           )
                              //         ],
                              //       ),
                              //     );
                              //   },
                              //   child: Container(
                              //     padding: EdgeInsets.symmetric(
                              //         vertical: 7, horizontal: 10),
                              //     decoration: BoxDecoration(
                              //         borderRadius: BorderRadius.circular(15),
                              //         color: Color(0XFF72C683)),
                              //     child: Row(
                              //       children: [
                              //         Text(
                              //           toBeginningOfSentenceCase(val),
                              //           style: smallPrimaryColor.copyWith(
                              //               color: whiteColor),
                              //         ),
                              //         Icon(
                              //           Icons.arrow_drop_down,
                              //           color: whiteColor,
                              //         )
                              //       ],
                              //     ),
                              //   ),
                              // ),
                              // kVerySmallWidth,
                              InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            NotificationScreen())),
                                child: SvgPicture.asset(
                                  'assets/images/svg/bell.svg',
                                ),
                              ),
                              kVerySmallWidth,
                              InkWell(
                                onTap: () {
                                  dialogBox(
                                      context,
                                      ProfilePopup(
                                        context: context,
                                        users: users,
                                        childIndex: childIndex,
                                        mainChildUser: mainChildUser,
                                      ));
                                },
                                child: SvgPicture.asset(
                                  'assets/images/svg/menu.svg',
                                ),
                              )
                              // profilePicture(context)
                            ],
                          )
                        ],
                      ),
                      kNormalHeight,
                      Container(
                        padding: EdgeInsets.only(right: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () => Navigator.pushNamed(
                                    context, SearchScreen.id),
                                child: SearchBox(
                                  type: 'route',
                                  padding: EdgeInsets.zero,
                                  placeholder: 'Search for subject',
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 25),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Color(0XFF006B17)),
                              child: SvgPicture.asset(
                                'assets/images/svg/s-icon.svg',
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            kLargeHeight,
            Padding(
              padding: defaultPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Column(
                  //   children: [
                  //     Headers(
                  //       text: 'Join live tutor sessions',
                  //       onTap: () {
                  //         Navigator.push(
                  //             context,
                  //             MaterialPageRoute(
                  //                 builder: (context) => AppLayout(
                  //                       index: 3,
                  //                     )));
                  //       },
                  //     ),
                  //     kSmallHeight,
                  //     Container(
                  //       height: 140,
                  //       child: ListView.separated(
                  //           separatorBuilder: (context, _) => kSmallWidth,
                  //           itemCount: 4,
                  //           shrinkWrap: true,
                  //           scrollDirection: Axis.horizontal,
                  //           itemBuilder: (context, index) {
                  //             return InkWell(
                  //               onTap: () {
                  //                 Navigator.push(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                         builder: (context) => AppLayout(
                  //                               index: 3,
                  //                             )));
                  //               },
                  //               child: SwipeItems(
                  //                 widget: Column(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     SwipeChild(),
                  //                   ],
                  //                 ),
                  //               ),
                  //             );
                  //           }),
                  //     ),
                  //   ],
                  // ),
                  // kLargeHeight,
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuizScreen(
                                  type: 'quick',
                                ))),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                      decoration: BoxDecoration(
                        color: accentColor,
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('assets/images/take_quiz.png')),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: SvgPicture.asset(
                              'assets/images/svg/quizz.svg',
                            ),
                          ),
                          Expanded(child: YellowButton())
                          // SvgPicture.asset(
                          //   'assets/images/svg/start_now.svg',
                          // )
                        ],
                      ),
                    ),
                  ),
                  kLargeHeight,
                  Column(
                    children: [
                      Headers(
                        text: 'Video lessons by subjects',
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AppLayout(
                                        index: 2,
                                      )));
                        },
                      ),
                      Container(
                        height: subject.length <= 3 ? 180 : 280,
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 100,
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 20),
                            itemCount: 6,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VideoLessons(
                                              subId: subject[index].id,
                                            ))),
                                child: SwipeItems(
                                  primaryColor: Color(int.parse(
                                      '0XFF${subject[index].primaryColor}')),
                                  secondaryColor: Color(int.parse(
                                      '0XFF${subject[index].secondaryColor}')),
                                  widget: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      FadeInImage(
                                        image:
                                            NetworkImage(subject[index].icon),
                                        height: 45,
                                        placeholder:
                                            AssetImage('assets/images/dna.png'),
                                      ),
                                      kVerySmallHeight,
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              subject[index].name,
                                              overflow: TextOverflow.ellipsis,
                                              style: heading18,
                                              textAlign: TextAlign.start,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                  childTopics.isEmpty
                      ? Container()
                      : Column(
                          children: [
                            kSmallHeight,
                            TextBox(
                              text: 'Recent viewed lessons',
                            ),
                            kSmallHeight,
                            Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              child: ListView.separated(
                                  separatorBuilder: (context, _) => kSmallWidth,
                                  itemCount: childTopics.length,
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  VideoFullScreen(
                                                    topic: childTopics[index]
                                                        .topic,
                                                  ))),
                                      child: SwipeItems(
                                        borderHeight: 80,
                                        borderWidth: 90,
                                        primaryColor: Color(int.parse(
                                            '0XFF${childTopics[index].topic.primaryColor}')),
                                        secondaryColor: Color(int.parse(
                                            '0XFF${childTopics[index].topic.secondaryColor}')),
                                        widget: SingleChildScrollView(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              SwipeChild(
                                                // height: 120,
                                                subject:
                                                    toBeginningOfSentenceCase(
                                                        childTopics[index]
                                                            .topic
                                                            .name),
                                                time:
                                                    '${childTopics[0].topic.video.duration} mins',
                                                slug: childTopics[index]
                                                    .topic
                                                    .icon,
                                                topic:
                                                    toBeginningOfSentenceCase(
                                                        childTopics[index]
                                                            .topic
                                                            .description),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                  kLargeHeight,
                  feed.isEmpty
                      ? Container()
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextBox(
                              text: 'People love our product',
                            ),
                            kSmallHeight,
                            Container(
                              height: 200,
                              child: ListView.separated(
                                separatorBuilder: (context, index) =>
                                    kSmallWidth,
                                itemCount: feed.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) => Container(
                                  width: 331,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 35, horizontal: 20),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                          color: accentColor, width: 0.6)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          feed[index].owner?.name ??
                                              'Anonymous',
                                          style: smallPrimaryColor.copyWith(
                                              color: accentColor,
                                              fontSize: 16)),
                                      kSmallHeight,
                                      Text(feed[index].message,
                                          style: smallPrimaryColor.copyWith(
                                              fontSize: 16)),
                                      kSmallHeight,
                                      Text(
                                          '${DateFormat('MMM d, y').format(feed[0].createdAt)}',
                                          style: smallPrimaryColor.copyWith(
                                              color: accentColor,
                                              fontSize: 12)),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                  kLargeHeight,
                  InkWell(
                    onTap: () => shareToSocials(context),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                      decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: accentColor, width: 0.6)),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/folder.png',
                          ),
                          kSmallWidth,
                          Text('Share the app with your friends',
                              style: smallPrimaryColor.copyWith(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),

                  // Container(
                  //   padding: defaultPadding.copyWith(right: 0),
                  //   child: GroupedWidgets(
                  //     data: data,
                  //     subject: subject,
                  //     text:
                  //         "Subjects based on ${toBeginningOfSentenceCase(users != null ? users[childIndex?.index ?? 0].name : mainChildUser.name)}'s class",
                  //   ),
                  // ),
                  kLargeHeight,
                  // Container(
                  //   padding: defaultPadding.copyWith(right: 0),
                  //   child: GroupedWidgets(
                  //     data: data,
                  //     subject: subject,
                  //     topic: childTopics,
                  //     type: 'topics',
                  //     text: 'Popular Topics',
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getStarted() {
    QuizProvider active = QuizProvider.quizProvider(context);
    QuizActive quizActive = QuizActive(active: false);
    active.setQuizActive(quizActive);
    print('quizActive:${quizActive.active}');
    _hiveRepository.add<QuizActive>(
        name: kQuizActive, key: 'quizActive', item: quizActive);
    Navigator.pop(context);
  }

  // onPressed() {
  //   dialogBox(
  //       context,
  //       Container(
  //         height: 400,
  //         width: 300,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.center,
  //           children: [
  //             Image.asset(
  //               'assets/images/gif/welcome.gif',
  //               height: 120,
  //             ),
  //             kSmallHeight,
  //             Text(
  //               'Welcome to Cliqlite!',
  //               style: headingPrimaryColor,
  //             ),
  //             kSmallHeight,
  //             Row(
  //               children: [
  //                 Expanded(
  //                   child: Text(
  //                     'Enjoy seven days free trial on quizzes and pay a subscription fee after',
  //                     style: heading18Black.copyWith(
  //                         fontWeight: FontWeight.normal, height: 2),
  //                     textAlign: TextAlign.center,
  //                   ),
  //                 )
  //               ],
  //             ),
  //             kSmallHeight,
  //             LargeButton(
  //               submit: () => getStarted(),
  //               color: secondaryColor,
  //               name: 'Get Started',
  //               buttonColor: primaryColor,
  //             ),
  //           ],
  //         ),
  //       ),
  //       onTap: () => Navigator.pop(context));
  // }

  @override
  void initState() {
    futureSubjects = futureTask();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Users> users = AuthProvider.auth(context).users;
    List<Subject> subject = SubjectProvider.subject(context).subjects;

    return BackgroundImage(
        child: FutureHelper(
            task: futureSubjects,
            loader: users == null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [circularProgressIndicator()],
                  )
                : home(children: users),
            builder: (context, _) => home(children: users))
        // FutureHelper(
        //     task: futureSubjects,
        //     loader: subject == null
        //         ? Column(
        //             crossAxisAlignment: CrossAxisAlignment.center,
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [circularProgressIndicator()],
        //           )
        //         : home(children: users),
        //     builder: (context, _) => home(children: users)),
        );
  }

  nextPage() {}
}

class YellowButton extends StatelessWidget {
  const YellowButton({
    Key key,
    this.text,
    this.onTap,
  }) : super(key: key);

  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
          elevation: MaterialStateProperty.all(text != null ? 0 : 6),
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(
              vertical: text != null ? 8 : 13,
              horizontal: text != null ? 14 : 20)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          )),
          backgroundColor: MaterialStateProperty.all(Color(0xffF8B800))),
      child: Text(
        text ?? 'Start Now',
        textAlign: TextAlign.center,
        style: textExtraLightBlack.copyWith(fontSize: text != null ? 11 : 15),
      ),
    );
  }
}

class SwipeItems extends StatelessWidget {
  const SwipeItems({
    Key key,
    this.widget,
    this.width,
    this.primaryColor,
    this.image,
    this.secondaryColor,
    this.borderHeight,
    this.borderWidth,
  }) : super(key: key);

  final Widget widget;
  final double width;
  final Color primaryColor;
  final Color secondaryColor;
  final String image;
  final double borderHeight;
  final double borderWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 330,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: primaryColor
          // image: DecorationImage(
          //     image: AssetImage(image ?? 'assets/images/peach_bg.png'),
          //     fit: BoxFit.fill)
          ),
      child: Indexer(
        alignment: AlignmentDirectional.topEnd,
        overflow: Overflow.clip,
        children: [
          Indexed(
            index: 1,
            child: Positioned(
                child: Container(
              height: borderHeight ?? 50,
              width: borderWidth ?? 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      topRight: Radius.circular(20)),
                  color: secondaryColor),
            )),
          ),
          Indexed(
            index: 2,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: widget),
          )
        ],
      ),
    );
  }
}

class SwipeChild extends StatelessWidget {
  const SwipeChild({
    Key key,
    this.height,
    this.widget,
    this.subject,
    this.time,
    this.slug,
    this.topic,
  }) : super(key: key);

  final double height;
  final Widget widget;
  final String subject;
  final String topic;
  final String time;
  final String slug;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    subject ?? '',
                    style: headingWhite.copyWith(
                        fontSize: 11, fontWeight: FontWeight.w400),
                  ),
                  // SizedBox(
                  //   width: 10,
                  // ),
                  // Container(
                  //   padding: EdgeInsets.symmetric(vertical: 3, horizontal: 16),
                  //   decoration: BoxDecoration(
                  //       color: redColor,
                  //       borderRadius: BorderRadius.circular(45)),
                  //   child: Text('LIVE',
                  //       style: headingWhite.copyWith(
                  //           fontSize: 10, fontWeight: FontWeight.w400)),
                  // )
                ],
              ),
              kSmallHeight,
              Row(
                children: [
                  Expanded(
                    child: Text(
                      topic ?? '',
                      textAlign: TextAlign.left,
                      style: headingWhite.copyWith(
                          fontSize: 18, fontWeight: FontWeight.w400),
                    ),
                  )
                ],
              ),
              kSmallHeight,
              Row(
                children: [
                  Icon(
                    Icons.access_time,
                    color: whiteColor,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    time ?? '',
                    style: headingWhite.copyWith(
                        fontSize: 11, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              kVerySmallHeight,
              widget ?? Container()
            ],
          ),
        ),
        Expanded(
          child: Container(
            height: height ?? 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                image: DecorationImage(
                    image: AssetImage('assets/images/image-1.png'))),
            child: Image.asset('assets/images/play_button.png'),
          ),
        )
      ],
    );
  }
}

class Headers extends StatelessWidget {
  const Headers({
    Key key,
    this.text,
    this.onTap,
  }) : super(key: key);

  final String text;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: smallPrimaryColor.copyWith(
              fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: secondaryColor),
          child: Row(
            children: [
              InkWell(
                onTap: onTap,
                child: Text(
                  'See All',
                  style: smallPrimaryColor.copyWith(color: accentColor),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class ProfilePopup extends StatelessWidget {
  const ProfilePopup({
    Key key,
    @required this.context,
    @required this.users,
    @required this.childIndex,
    @required this.mainChildUser,
  }) : super(key: key);

  final BuildContext context;
  final List<Users> users;
  final ChildIndex childIndex;
  final MainChildUser mainChildUser;

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = AuthProvider.auth(context);

    return Container(
      height: 350,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              profilePicture(context),
              kSmallWidth,
              Text(
                ' ${toBeginningOfSentenceCase(users != null ? users[childIndex?.index ?? 0].name.split(' ')[0] : mainChildUser.name.split(' ')[0])}',
                style: smallPrimaryColor.copyWith(fontSize: 18),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
              ),
            ],
          ),
          kLargeHeight,
          // InkWell(
          //   onTap: () => Navigator.pushNamed(context, MyPoints.id),
          //   child: Text(
          //     'My points',
          //     style: smallPrimaryColor.copyWith(fontSize: 16),
          //   ),
          // ),
          // Divider(
          //   thickness: 1,
          //   height: 40,
          // ),
          auth.user.role != 'child'
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pushNamed(context, ProfileBody.id),
                      child: Text(
                        'Manage profiles',
                        style: smallPrimaryColor.copyWith(fontSize: 16),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      height: 40,
                    ),
                  ],
                )
              : Container(),

          InkWell(
            onTap: () async {
              await AuthProvider.auth(context).logout();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Login.id, (Route<dynamic> route) => false);
            },
            child: Text(
              'Log out',
              style: smallPrimaryColor.copyWith(fontSize: 16),
            ),
          ),
          Divider(
            thickness: 1,
            height: 40,
          ),
          GreenButton(
            submit: () => Navigator.pop(context),
            color: primaryColor,
            name: 'Close',
            buttonColor: secondaryColor,
            loader: false,
          ),
        ],
      ),
    );
  }
}

// class GroupedWidgets extends StatelessWidget {
//   const GroupedWidgets(
//       {@required this.data,
//       this.text,
//       this.onPressed,
//       this.subject,
//       this.video,
//       this.type,
//       this.topic});
//
//   final List<Map<String, String>> data;
//   final List<Subject> subject;
//   final List<Video> video;
//   final List<RecentTopic> topic;
//   final String type;
//   final String text;
//   final Function onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     ThemeProvider theme = ThemeProvider.themeProvider(context);
//     ChildIndex childIndex = SubjectProvider.subject(context).index;
//     List<Users> users = AuthProvider.auth(context).users;
//     MainChildUser mainChildUser = AuthProvider.auth(context).mainChildUser;
//     bool subscribed = users != null
//         ? users[childIndex?.index ?? 0].isSubscribed
//         : mainChildUser.isSubscribed;
//
//     onTap(String name, String subjectId) {
//       Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) => SubjectScreen(
//                     text: name,
//                     route: 'home',
//                     subjectId: subjectId,
//                     topic: topic,
//                   )));
//     }
//
//     onTapVideo(Video video) {
//       if (subscribed) {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => VideoFullScreen(
//                       video: video,
//                     )));
//       } else {
//         Navigator.pushNamed(context, MakeSubscription.id);
//       }
//     }
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           text,
//           style: theme.status ? headingWhite : heading18Black,
//         ),
//         kSmallHeight,
//         Container(
//           height: 160,
//           child: ListView.separated(
//               separatorBuilder: (context, index) => SizedBox(
//                     width: 10,
//                   ),
//               scrollDirection: Axis.horizontal,
//               itemCount: type == 'videos'
//                   ? video.length
//                   : (type == 'topics' ? topic.length : subject.length),
//               shrinkWrap: true,
//               itemBuilder: (context, index) {
//                 return Stack(
//                   overflow: Overflow.visible,
//                   alignment: Alignment.topCenter,
//                   children: [
//                     // InkWell(
//                     //   onTap: onPressed ??
//                     //       () => type == 'videos'
//                     //           ? onTapVideo(video[index])
//                     //           : (type == 'topics'
//                     //               ? null
//                     //               : onTap(subject[index].name,
//                     //                   subject[index].subjectId)),
//                     //   child: ClipRRect(
//                     //     child: FadeInImage(
//                     //       image: NetworkImage(type == 'videos'
//                     //           ? 'https://images.pexels.com/photos/8065871/pexels-photo-8065871.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'
//                     //           : (type == 'topics'
//                     //               ? 'https://images.pexels.com/photos/8065871/pexels-photo-8065871.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=750&w=1260'
//                     //               : subject[index].photo)),
//                     //       placeholder: AssetImage(
//                     //         data[0]['image'],
//                     //       ),
//                     //       width: 100.0,
//                     //       height: 170.0,
//                     //       fit: BoxFit.cover,
//                     //     ),
//                     //     // clipper: ,
//                     //     borderRadius: BorderRadius.circular(15.0),
//                     //   ),
//                     // ),
//                     // Positioned(
//                     //   child: Row(
//                     //     mainAxisAlignment: MainAxisAlignment.center,
//                     //     children: [
//                     //       Expanded(
//                     //         child: Text(
//                     //           type == 'videos'
//                     //               ? video[index].title
//                     //               : (type == 'topics'
//                     //                   ? topic[index].title
//                     //                   : subject[index].name),
//                     //           style: headingWhite.copyWith(fontSize: 13),
//                     //           overflow: TextOverflow.ellipsis,
//                     //           textAlign: TextAlign.center,
//                     //         ),
//                     //       )
//                     //     ],
//                     //   ),
//                     //   bottom: 60,
//                     //   right: 0,
//                     //   left: 0,
//                     // )
//                   ],
//                 );
//               }),
//         )
//       ],
//     );
//   }
// }
