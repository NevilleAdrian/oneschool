import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/screens/auth/login.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:cliqlite/utils/text_form.dart';
import 'package:cliqlite/utils/validations.dart';
import 'package:flutter/material.dart';

class RecoverPassword extends StatefulWidget {
  RecoverPassword({this.token});
  final String token;
  @override
  _RecoverPasswordState createState() => _RecoverPasswordState();
}

class _RecoverPasswordState extends State<RecoverPassword> {
  bool autoValidate = false;
  TextEditingController _controllerConfirm = new TextEditingController();
  TextEditingController _controllerPassword = new TextEditingController();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Validations validations = new Validations();

  nextPage(BuildContext context) async {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autoValidate = true; // Start validating on every change.
    } else {
      try {
        setState(() {
          AuthProvider.auth(context).setIsLoading(true);
        });
        var result = await AuthProvider.auth(context).resetPassword(
            int.parse(widget.token),
            _controllerPassword.text,
            _controllerConfirm.text);

        if (result != null) {
          showFlush(context, 'Password updated successfully', primaryColor);

          Navigator.pushNamed(context, Login.id);

          setState(() {
            AuthProvider.auth(context).setIsLoading(false);
          });
        }
      } catch (ex) {
        showFlush(context, ex.toString(), primaryColor);
        setState(() {
          AuthProvider.auth(context).setIsLoading(false);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = AuthProvider.auth(context);

    return BackgroundImage(
        child: SingleChildScrollView(
            child: SafeArea(
                child: Padding(
      padding: defaultVHPadding,
      child: Column(
        children: [
          BackArrow(
            text: 'Recover Password',
          ),
          kLargeHeight,
          Form(
              key: formKey,
              child: Column(
                children: [
                  MyTextForm(
                      controllerName: _controllerPassword,
                      validations: validations.validatePassword,
                      type: TextInputType.text,
                      hintText: 'Password'),
                  kSmallHeight,
                  MyTextForm(
                      controllerName: _controllerConfirm,
                      validations: validations.validatePassword,
                      type: TextInputType.text,
                      hintText: 'Confirm Password'),
                  kLargeHeight,
                  GreenButton(
                    submit: () {
                      nextPage(context);
                    },
                    color: primaryColor,
                    name: 'Submit',
                    buttonColor: secondaryColor,
                    loader: auth.isLoading,
                  ),
                  kSmallHeight,
                ],
              ))
        ],
      ),
    ))));
  }
}
