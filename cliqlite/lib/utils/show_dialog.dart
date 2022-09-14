import 'package:cliqlite/models/auth_model/main_auth_user/main_auth_user.dart';
import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/child_provider/child_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/x_button.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

dynamic dialogBox(
  BuildContext context,
  Widget widget, {
  Widget top,
  Function onTap,
}) {
  return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          title: top ??
              XButton(
                onTap: onTap ?? () => Navigator.pop(context),
              ),
          content: widget,
        );
      });
}

Future<dynamic> openBottomSheet(BuildContext context, Widget widget) async {
  return await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return Container(
        height: MediaQuery.of(context).size.height * 1 / 1.6,
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            )),
        child: widget,
      );
    },
  );
}

void showFlush(BuildContext context, String message, Color color) {
  Flushbar(
    backgroundColor: color == primaryColor ? accentColor : color,
    message: message,
    duration: Duration(seconds: 7),
    flushbarStyle: FlushbarStyle.GROUNDED,
  ).show(context);
}

Widget circularProgressIndicator([Color color]) => CircularProgressIndicator(
      strokeWidth: 1,
      backgroundColor: Colors.white,
      valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
    );

String toDecimalPlace(dynamic item, [int value = 2]) {
  return item.toStringAsFixed(value);
}

String addSeparator(String item) {
  return item.replaceAllMapped(
      new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
}

Widget profilePicture(BuildContext context, String type, {double size}) {
  //Initialize provider
  List<dynamic> mockChildren = ChildProvider.childProvider(context).children;
  SubjectProvider subject = SubjectProvider.subject(context);
  AuthProvider auth = AuthProvider.auth(context);
  MainChildUser mainChildUser = AuthProvider.auth(context).mainChildUser;
  ChildIndex childIndex = subject.index;
  String profilePic = AuthProvider.auth(context).users != null
      ? AuthProvider.auth(context).users[childIndex?.index ?? 0]?.photo
      : mainChildUser?.photo;

  print('profilepic:$profilePic ');

  return InkWell(
      onTap: () {
        // if (auth.user.role != 'user') {
        //   onTap(context);
        // }
      },
      child: profilePic == null || profilePic == ''
          ? Container(
              width: size ?? 65,
              height: size ?? 65,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(
                      'assets/images/woman.png',
                    ),
                  )),
            )
          : (type == 'photo'
              ? Container(
                  width: size ?? 65,
                  height: size ?? 65,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/woman.png',
                        ),
                      )),
                )
              : Container(
                  width: size ?? 65,
                  height: size ?? 65,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(
                            profilePic ?? mockChildren[0]['image_url']),
                      )),
                ))
      // Container(
      //         decoration: BoxDecoration(shape: BoxShape.circle
      //             //color: Theme.of(context).backgroundColor,
      //             ),
      //         child: FadeInImage(
      //           image: NetworkImage(profilePic ?? mockChildren[0]['image_url']),
      //           placeholder: AssetImage(
      //             'assets/images/picture.png',
      //           ),
      //           width: 35.0,
      //           height: 35.0,
      //           fit: BoxFit.cover,
      //         ),
      //       ),
      );
}
