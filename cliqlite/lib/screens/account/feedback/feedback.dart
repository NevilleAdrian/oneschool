import 'package:cliqlite/models/auth_model/main_auth_user/main_auth_user.dart';
import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/providers/topic_provider/topic_provider.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:cliqlite/utils/text_form.dart';
import 'package:cliqlite/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class FeedBackScreen extends StatefulWidget {
  static String id = 'feedback';

  FeedBackScreen({this.topicID, this.name});
  final String topicID;
  final String name;

  @override
  _FeedBackScreenState createState() => _FeedBackScreenState();
}

class _FeedBackScreenState extends State<FeedBackScreen> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Validations validations = new Validations();
  TextEditingController _controllerName = new TextEditingController();
  TextEditingController _controllerDescription = new TextEditingController();
  double rated = 3;
  nextPage() async {
    //Set Loader
    setState(() {
      AuthProvider.auth(context).setIsLoading(true);
    });
    try {
      //Submit Quiz
      var result = await TopicProvider.topic(context).submitFeedback(
          // topicId: widget.topicID,
          text: _controllerDescription.text,
          rating: rated);

      if (result != null) {
        setState(() {
          AuthProvider.auth(context).setIsLoading(false);
        });
        showFlush(context, 'Successfully Submitted Feedback', primaryColor);
        _controllerDescription.clear();
      }
    } catch (ex) {
      setState(() {
        AuthProvider.auth(context).setIsLoading(false);
      });
      showFlush(context, ex.toString(), primaryColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = AuthProvider.auth(context);
    MainChildUser child = AuthProvider.auth(context).mainChildUser;
    SubjectProvider subject = SubjectProvider.subject(context);
    ChildIndex childIndex = subject.index;

    String name = auth.user.role == 'child'
        ? child.name.toLowerCase()
        : (auth?.users[childIndex?.index ?? 0]?.name);

    return BackgroundImage(
      child: SafeArea(
        child: Padding(
          padding: defaultVHPadding,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.arrow_back_outlined,
                        color: blackColor,
                      )),
                  Text(
                    "Feedback",
                    textAlign: TextAlign.center,
                    style: textStyleSmall.copyWith(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w700,
                        color: primaryColor),
                  ),
                  Container()
                ],
              ),
              kLargeHeight,
              SingleChildScrollView(
                child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        MyTextForm(
                          controllerName: _controllerName,
                          validations: validations.validateName,
                          hintText: toBeginningOfSentenceCase(name),
                          readonly: true,
                        ),
                        kSmallHeight,
                        MyTextForm(
                          controllerName: _controllerDescription,
                          validations: validations.validateName,
                          hintText: 'Leave Comment',
                          area: 10,
                        ),
                        kLargeHeight,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Rate the app',
                              style: headingSmallBlack.copyWith(
                                  fontWeight: FontWeight.w600),
                            ),
                            RatingBar.builder(
                              initialRating: 3,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemSize: 22,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                                setState(() {
                                  rated = rating;
                                });
                              },
                            )
                          ],
                        ),
                        kLargeHeight,
                        GreenButton(
                          submit: () => nextPage(),
                          color: primaryColor,
                          name: 'Send Feedback',
                          buttonColor: secondaryColor,
                          loader: auth.isLoading,
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//Modal bottom sheet
// void feedBackSheet(BuildContext context, String type) {
//   showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       builder: (BuildContext context) {
//         return StatefulBuilder(
//           builder: (BuildContext context, StateSetter setModalState) {
//             return Container(
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       InkWell(
//                         onTap: () => Navigator.pop(context),
//                         child: Padding(
//                           padding: const EdgeInsets.only(right: 20),
//                           child: Text(
//                             'Close',
//                             style: headingWhite,
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                   kVerySmallHeight,
//                   Expanded(
//                     child: Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.only(
//                               topLeft: Radius.circular(40.0),
//                               topRight: Radius.circular(40.0)),
//                           color: lightPrimaryColor),
//                       height: 500.0,
//                       child: Container(
//                           padding: EdgeInsets.symmetric(
//                               vertical: 40, horizontal: 20),
//                           child: ListView.builder(
//                               itemCount: type == 'age'
//                                   ? childYears.length
//                                   : grades.length,
//                               itemBuilder: (context, index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.only(bottom: 10),
//                                   child: Row(
//                                     children: [
//                                       Radio(
//                                           value: type == 'age'
//                                               ? childYears[index]['years']
//                                               : toBeginningOfSentenceCase(
//                                               grades[index].name),
//                                           groupValue:
//                                           type == 'age' ? val : classVal,
//                                           activeColor: primaryColor,
//                                           onChanged: (var value) {
//                                             setModalState(() {
//                                               setState(() {});
//                                               if (type == 'age') {
//                                                 val = value;
//                                                 age =
//                                                 childYears[index]['name'];
//                                               } else {
//                                                 classVal = value;
//                                                 childClassName =
//                                                     grades[index].gradeId;
//                                                 print(
//                                                     'classNme:$childClassName');
//                                                 print('classNme:$classVal');
//                                               }
//                                             });
//                                           }),
//                                       // kSmallWidth,
//                                       Text(
//                                         type == 'age'
//                                             ? childYears[index]['name']
//                                             : toBeginningOfSentenceCase(
//                                             grades[index].name),
//                                         style: textLightBlack,
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               })),
//                     ),
//                   )
//                 ],
//               ),
//             );
//           },
//         );
//       });
// }
