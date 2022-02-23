import 'package:cliqlite/models/auth_model/main_auth_user/main_auth_user.dart';
import 'package:cliqlite/models/subject/subject.dart';
import 'package:cliqlite/models/users_model/users.dart';
import 'package:cliqlite/providers/analytics_provider/analytics_provider.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/child_provider/child_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/auth/child_registration.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:cliqlite/utils/outline_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class ProfileBody extends StatefulWidget {
  static String id = 'prof-body';
  const ProfileBody({
    Key key,
    @required this.context,
  }) : super(key: key);

  final BuildContext context;

  @override
  _ProfileBodyState createState() => _ProfileBodyState();
}

class _ProfileBodyState extends State<ProfileBody> {
  String val;
  @override
  void initState() {
    List<Users> children = AuthProvider.auth(context).users;
    val = children[0].name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> mockChild = ChildProvider.childProvider(context).children;
    List<Users> children = AuthProvider.auth(context).users;
    MainChildUser child = AuthProvider.auth(context).mainChildUser;
    SubjectProvider subject = SubjectProvider.subject(context);
    List<dynamic> mockChildren = ChildProvider.childProvider(context).children;
    AuthProvider auth = AuthProvider.auth(context);
    AnalyticsProvider analytic = AnalyticsProvider.analytics(context);

    changeSubject(int index) async {
      try {
        // //Set Global spinner
        subject.setSpinner(true);

        // Make call to get subjects
        List<Subject> result = await subject.getSubjects(
            id: children[index].grade,
            name: children[index].name,
            index: index);
        await analytic.getTopic();

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

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: defaultVHPadding,
            child: Column(
              children: [
                BackArrow(
                  text: 'Manage profiles',
                ),
                kSmallHeight,
                children.isNotEmpty
                    ? Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 200,
                                    crossAxisCount: 2,
                                    // childAspectRatio: 0,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemCount: children.length,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              Users user = children[index];
                              print('photo:${user?.photo}');
                              print('photo:${child?.photo}');
                              String name = auth.user.role == 'child'
                                  ? child.name
                                  : (user?.name);
                              String photo = auth.user.role == 'child'
                                  ? child.photo
                                  : (user?.photo);
                              return ItemBoxes(
                                image: photo,
                                index: index,
                                text: toBeginningOfSentenceCase(name),
                                value: auth.user.role != 'child'
                                    ? child?.name
                                    : user?.name,
                                attribute: val,
                                onTap: () {
                                  setState(() => val = auth.user.role != 'child'
                                      ? child?.name
                                      : user?.name);
                                  changeSubject(index);
                                },
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
                  text: 'Add another child',
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ItemBoxes extends StatelessWidget {
  const ItemBoxes({
    Key key,
    this.image,
    this.text,
    this.attribute,
    this.value,
    this.onTap,
    this.index,
  }) : super(key: key);

  final String image;
  final String text;
  final String attribute;
  final String value;
  final int index;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    print('value:$value');
    print('attribute:$attribute');
    print('index:$index');
    List<Users> children = AuthProvider.auth(context).users;
    // print('valuee:${SubjectProvider.subject(context)?.grade?.name}');
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: children[index].name ==
                    SubjectProvider.subject(context)?.grade?.name
                ? Border.all(color: accentColor, width: 1)
                : Border.all(color: greyColor, width: 0.4),
            color: backgroundColor),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                children[index].name ==
                        SubjectProvider.subject(context)?.grade?.name
                    ? Icon(Icons.check_circle, color: accentColor)
                    : Container(
                        height: 23,
                      ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: image != null
                              ? NetworkImage(image)
                              : AssetImage(
                                  'assets/images/woman.png',
                                ))),
                ),
                kSmallHeight,
                Text(
                  text ?? '',
                  style: smallPrimaryColor.copyWith(fontSize: 16),
                ),
              ],
            ),
            kSmallHeight,
            // Row(
            //   children: [
            //     ItemButtons(
            //       text: 'Edit',
            //       image: 'assets/images/svg/pen.svg',
            //       buttonColor: lighterPrimaryColor,
            //     ),
            //     kVerySmallWidth,
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}

class ItemButtons extends StatelessWidget {
  const ItemButtons({
    Key key,
    this.text,
    this.image,
    this.color,
    this.buttonColor,
  }) : super(key: key);

  final String text;
  final String image;
  final Color color;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7, horizontal: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: buttonColor),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(image),
            kVerySmallWidth,
            Text(
              text,
              style: smallPrimaryColor.copyWith(
                  fontSize: 11, color: color ?? primaryColor),
            )
          ],
        ),
      ),
    );
  }
}
