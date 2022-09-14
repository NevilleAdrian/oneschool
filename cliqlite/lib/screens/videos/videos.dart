import 'package:cliqlite/models/subject/subject.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/home/home.dart';
import 'package:cliqlite/screens/videos/video_lessons.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:cliqlite/utils/text_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Videos extends StatefulWidget {
  @override
  _VideosState createState() => _VideosState();
}

class _VideosState extends State<Videos> {
  Future<List<Subject>> futureSubjects;

  List<Subject> subject;

  Future<List<Subject>> futureTask() async {
    //Initialize provider
    SubjectProvider subject = SubjectProvider.subject(context);
    AuthProvider auth = AuthProvider.auth(context);

    //Make call to get videos
    var result = await subject.getSubjects(
      id: subject?.grade?.grade ?? auth.users[0].grade,
      name: subject?.grade?.name ?? auth.users[0].name,
    );

    setState(() {});

    //Return future value
    return Future.value(result);
  }

  Widget videos(List<Subject> subject) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: defaultVHPadding.copyWith(left: 0, top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Video lessons',
                    textAlign: TextAlign.center,
                    style: textStyleSmall.copyWith(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w700,
                        color: primaryColor),
                  ),
                  // InkWell(
                  //   onTap: () => Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //           builder: (context) => SearchScreen(
                  //                 route: 'videos',
                  //               ))),
                  //   cshild: SearchBox(
                  //     type: 'route',
                  //     width: MediaQuery.of(context).size.width / 1.4,
                  //     placeholder: 'Search for Videos',
                  //   ),
                  // ),
                  // profilePicture(context)
                ],
              ),
            ),
            Container(
              padding: defaultPadding,
              child: Column(
                children: [
                  // SearchCard(),
                  kSmallHeight,
                  Column(
                    children: [
                      TextBox(
                        text: 'All video lessons available',
                      ),
                      kSmallHeight,
                      Container(
                        height: 370,
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 100,
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 20),
                            itemCount: subject.length,
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
                  )
                ],
              ),
            ),

            // Container(
            //   padding: defaultPadding.copyWith(right: 0),
            //   child: GroupedWidgets(
            //     data: data,
            //     video: video,
            //     type: 'videos',
            //     text: "Popular Videos",
            //     onPressed: () => onPressed(video),
            //   ),
            // ),
            // kSmallHeight,
            // Container(
            //   padding: defaultPadding.copyWith(right: 0),
            //   child: GroupedWidgets(
            //     data: data,
            //     video: video
            //         .where((element) => element.tags.contains('music'))
            //         .toList(),
            //     type: 'videos',
            //     text: "Music Videos",
            //     // onPressed: () => onPressed(video),
            //   ),
            // ),
            // kSmallHeight,
            // Container(
            //   padding: defaultPadding.copyWith(right: 0),
            //   child: GroupedWidgets(
            //     data: data,
            //     video: video
            //         .where((element) => element.tags.contains('science'))
            //         .toList(),
            //     type: 'videos',
            //     text: "Science Videos",
            //     // onPressed: () => onPressed(video),
            //   ),
            // ),
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
    List<Subject> subject = SubjectProvider.subject(context).subjects;

    return BackgroundImage(
      child: FutureHelper(
        task: futureSubjects,
        loader: subject == null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [circularProgressIndicator()],
              )
            : videos(subject),
        builder: (context, _) => videos(subject),
      ),
    );
  }
}

class SearchCard extends StatelessWidget {
  const SearchCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 21),
      decoration: BoxDecoration(
          color: lightPrimaryColor,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: accentColor, width: 0.5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Search for subject or tutor',
            style: headingSmallGreyColor.copyWith(fontSize: 14),
          ),
          SvgPicture.asset('assets/images/svg/search-icon.svg')
        ],
      ),
    );
  }
}
