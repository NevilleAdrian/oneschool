import 'package:cliqlite/screens/home/profile_body.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/cupertino.dart';

onTap(BuildContext context) {
  dialogBox(context, ProfileBody(context: context),
      onTap: () => Navigator.pop(context));
}
