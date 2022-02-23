import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {
  const DropDown({
    Key key,
    this.text,
    this.color,
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 15),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: Colors.transparent,
          border: Border.all(color: accentColor, width: 1)),
      child: Row(
        children: [
          Text(
            text,
            style: smallPrimaryColor,
          ),
          const SizedBox(
            width: 8,
          ),
          const Icon(Icons.arrow_drop_down_rounded)
        ],
      ),
    );
  }
}
