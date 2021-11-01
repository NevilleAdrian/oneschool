import 'package:cached_network_image/cached_network_image.dart';
import 'package:cliqlite/models/auth_model/auth_user/auth_user.dart';
import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
import 'package:cliqlite/models/mock_data/mock_data.dart';
import 'package:cliqlite/models/subject/grade/grade.dart';
import 'package:cliqlite/models/subject/subject.dart';
import 'package:cliqlite/models/users_model/users.dart';
import 'package:cliqlite/models/video_model/video_model.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/child_provider/child_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/auth/child_registration.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/home/make_subscription.dart';
import 'package:cliqlite/screens/home/notifications.dart';
import 'package:cliqlite/screens/search_screen/search_screen.dart';
import 'package:cliqlite/screens/subject_screen/subject_screen.dart';
import 'package:cliqlite/screens/videos/video_fulls_screen.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/dialog_box.dart';
import 'package:cliqlite/utils/outline_button.dart';
import 'package:cliqlite/utils/search_box.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class Home extends StatefulWidget {
  static String id = "home";
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String profilePic;
  Future<List<Subject>> futureSubjects;

  Future<List<Subject>> futureTask() async {
    //Initialize provider
    SubjectProvider subject = SubjectProvider.subject(context);
    AuthProvider auth = AuthProvider.auth(context);

    print('gradee:${subject?.grade?.grade}');
    print('auth-gradee:${auth.user.toJson()}');

    //Make call to get grades
    await AuthProvider.auth(context).getGrades();

    List<Subject> data;
    //Make call to get child
    if (auth.user.role != 'user') {
      await AuthProvider.auth(context).getChildren();
      data = await subject.getSubjects(
        id: subject?.grade?.grade ?? auth.users[0].grade,
        name: subject?.grade?.name ?? auth.users[0].name,
      );
    } else {
      //Make call to get subjects
      data = await subject.getSubjects(
        id: auth.user.grade,
        name: auth.user.fullname,
      );
    }

    setState(() {
      if (data != null) {
        subject.setSpinner(false);
      }
    });

    ChildIndex childIndex = SubjectProvider.subject(context).index;
    List<Users> users = AuthProvider.auth(context).users;
    profilePic = users[childIndex.index ?? 0].photo;
    //Return future value
    return Future.value(data);
  }

  Widget home({List<Users> children}) {
    List<dynamic> mockChildren = ChildProvider.childProvider(context).children;
    AuthUser user = AuthProvider.auth(context).user;
    List<Subject> subject = SubjectProvider.subject(context).subjects;
    Grade grade = SubjectProvider.subject(context).grade;
    ChildIndex childIndex = SubjectProvider.subject(context).index;
    List<Users> users = AuthProvider.auth(context).users;
    profilePic = users[childIndex.index ?? 0].photo;

    print('photo:${users[childIndex.index ?? 0].photo}');

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
                          Text(
                              'Hello ${toBeginningOfSentenceCase(grade.name ?? children[0].name) ?? mockChildren[0]['name']}',
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
                            onTap: () {
                              if (user.role != 'user') {
                                onTap(context);
                              }
                            },
                            child: profilePic == 'no-photo.jpg'
                                ? Image.asset(
                                    'assets/images/picture.png',
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      borderRadius: new BorderRadius.all(
                                          const Radius.circular(10.0)),
                                      //color: Theme.of(context).backgroundColor,
                                    ),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        child: CachedNetworkImage(
                                          imageUrl: profilePic,
                                          width: 35.0,
                                          height: 35.0,
                                          fit: BoxFit.cover,
                                        )),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: defaultPadding.copyWith(right: 0),
                  child: GroupedWidgets(
                    data: data,
                    subject: subject,
                    text:
                        "Subjects based on ${toBeginningOfSentenceCase(grade.name ?? children[0].name) ?? mockChildren[0]['name']}'s class",
                  ),
                ),
                Container(
                  padding: defaultPadding.copyWith(right: 0),
                  child: GroupedWidgets(
                    data: data,
                    subject: subject,
                    text: 'Popular Subjects',
                  ),
                ),
                Container(
                  padding: defaultPadding.copyWith(right: 0),
                  child: GroupedWidgets(
                    data: data,
                    subject: subject,
                    text: 'Popular Classes',
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    futureSubjects = futureTask();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Users> users = AuthProvider.auth(context).users;
    List<Subject> subject = SubjectProvider.subject(context).subjects;
    print('spinner:${SubjectProvider.subject(context).spinner}');
    return BackgroundImage(
      child: FutureHelper(
          task: futureSubjects,
          loader: subject == null
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [circularProgressIndicator()],
                )
              : home(children: users),
          builder: (context, _) => home(children: users)),
    );
  }
}

class DialogBody extends StatefulWidget {
  const DialogBody({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  _DialogBodyState createState() => _DialogBodyState();
}

class _DialogBodyState extends State<DialogBody> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> mockChild = ChildProvider.childProvider(context).children;
    List<Users> children = AuthProvider.auth(context).users;
    SubjectProvider subject = SubjectProvider.subject(context);

    changeSubject(int index) async {
      try {
        // //Set Global spinner
        subject.setSpinner(true);

        // Make call to get subjects
        List<Subject> result = await subject.getSubjects(
            id: children[index].grade,
            name: children[index].name,
            index: index);

        // Make call to get result
        if (result != null) {
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppLayout.id, (Route<dynamic> route) => false);
        }
      } catch (ex) {
        print(ex);
        subject.setSpinner(false);
      }
    }

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
                              child: InkWell(
                                onTap: () => changeSubject(index),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: children[index].grade ==
                                                    SubjectProvider.subject(
                                                            context)
                                                        ?.grade
                                                        ?.grade
                                                ? Border.all(
                                                    color: primaryColor,
                                                    width: 2.0)
                                                : Border(),
                                            borderRadius:
                                                BorderRadius.circular(6)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: new BorderRadius.all(
                                                const Radius.circular(10.0)),
                                            //color: Theme.of(context).backgroundColor,
                                          ),
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              child: CachedNetworkImage(
                                                imageUrl: children[index].photo,
                                                width: 60.0,
                                                height: 35.0,
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      toBeginningOfSentenceCase(
                                          children[index].name ??
                                              mockChild[0]['name']),
                                      style:
                                          textLightBlack.copyWith(fontSize: 12),
                                    )
                                  ],
                                ),
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
  const GroupedWidgets(
      {@required this.data,
      this.text,
      this.onPressed,
      this.subject,
      this.video,
      this.type});

  final List<Map<String, String>> data;
  final List<Subject> subject;
  final List<Video> video;
  final String type;
  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = ThemeProvider.themeProvider(context);
    ChildIndex childIndex = SubjectProvider.subject(context).index;
    List<Users> users = AuthProvider.auth(context).users;
    print('subscribed: ${users[childIndex.index ?? 0].isSubscribed}');
    bool subscribed = users[childIndex.index ?? 0].isSubscribed;

    onTap(String name, String subjectId) {
      if (subscribed) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SubjectScreen(
                      text: name,
                      route: 'home',
                      subjectId: subjectId,
                    )));
      } else {
        Navigator.pushNamed(context, MakeSubscription.id);
      }
    }

    onTapVideo(Video video) {
      if (subscribed) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoFullScreen(
                      video: video,
                    )));
      } else {
        Navigator.pushNamed(context, MakeSubscription.id);
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: theme.status ? headingWhite : heading18Black,
        ),
        kSmallHeight,
        Container(
          height: 160,
          child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(
                    width: 10,
                  ),
              scrollDirection: Axis.horizontal,
              itemCount: type == 'videos' ? video.length : subject.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    InkWell(
                      onTap: onPressed ??
                          () => type == 'videos'
                              ? onTapVideo(video[index])
                              : onTap(subject[index].name,
                                  subject[index].subjectId),
                      child: Image.asset(
                        type == 'videos'
                            ? data[index]['image']
                            : (subject[index].photo == 'no-photo.jpg'
                                ? data[index]['image']
                                : subject[index].photo),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            type == 'videos'
                                ? video[index].title
                                : subject[index].name,
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
