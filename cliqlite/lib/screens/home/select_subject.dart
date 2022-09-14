import 'package:cliqlite/models/subject/subject.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/home/home.dart';
import 'package:cliqlite/screens/quiz_screen/quiz_screen.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/ui_widgets/future_helper.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/material.dart';

class SelectSubject extends StatefulWidget {
  static String id = 'select';
  @override
  _SelectSubjectState createState() => _SelectSubjectState();
}

class _SelectSubjectState extends State<SelectSubject> {
  Future<List<Subject>> futureSubjects;

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
            BackArrow(),
            kLargeHeight,
            Container(
              padding: defaultPadding,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Select any subject to start',
                        textAlign: TextAlign.center,
                        style: textStyleSmall.copyWith(
                            fontSize: 21.0,
                            fontWeight: FontWeight.w700,
                            color: primaryColor),
                      ),
                    ],
                  ),
                  // kSmallHeight,
                  // SearchCard(),
                  kSmallHeight,
                  Column(
                    children: [
                      // TextBox(
                      //   text: 'All video lessons available',
                      // ),
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
                              print('subId: ${subject[index].subjectId}');
                              return InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => QuizScreen(
                                              type: 'quick',
                                              subjectId: subject[index].id,
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
    print('subjects: $subject');

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
