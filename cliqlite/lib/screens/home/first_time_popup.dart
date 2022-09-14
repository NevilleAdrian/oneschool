import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';

class FirstTimePopup extends StatefulWidget {
  @override
  _FirstTimePopupState createState() => _FirstTimePopupState();
}

class _FirstTimePopupState extends State<FirstTimePopup> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 380,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                'You are signed in to a Parent account',
                style: smallPrimaryColor.copyWith(
                    fontSize: 17, fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "To take a Quiz, kindly log into your Child's account.",
                textAlign: TextAlign.center,
                style: smallPrimaryColor.copyWith(
                    fontSize: 14, color: Colors.black),
              ),
            ],
          ),
          Image.asset('assets/images/first_time.png'),
          InkWell(
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 21),
              decoration: BoxDecoration(
                  color: lightPrimaryColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: accentColor, width: 0.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Close',
                    textAlign: TextAlign.center,
                    style: smallPrimaryColor,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
