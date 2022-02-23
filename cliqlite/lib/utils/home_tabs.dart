import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';

class HomeTabs extends StatelessWidget {
  HomeTabs({
    Key key,
    this.attribute,
    this.onChanged,
    this.groupVal,
    this.text,
  }) : super(key: key);
  String attribute;
  String groupVal;
  Function onChanged;
  String text;

  @override
  Widget build(BuildContext context) {
    print('groupVal:$groupVal');
    print('attribute:$attribute');
    return InkWell(
      onTap: onChanged,
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 5, right: 15),
        decoration: BoxDecoration(
            color: lightPrimaryColor, borderRadius: BorderRadius.circular(15)),
        child: AppBar(
          elevation: 0,
          leading: Container(),
          backgroundColor: lightPrimaryColor,
          title: Text(
            text,
            style: smallPrimaryColor.copyWith(
                fontSize: 16, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          ),
          actions: [
            groupVal == attribute
                ? Icon(
                    Icons.check_circle,
                    color: accentColor,
                    size: 22,
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
