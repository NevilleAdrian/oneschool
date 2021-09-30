import 'package:cliqlite/screens/home/home.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/cupertino.dart';

onTap(BuildContext context) {
  dialogBox(context, DialogBody(context: context),
      onTap: () => Navigator.pop(context));
}
