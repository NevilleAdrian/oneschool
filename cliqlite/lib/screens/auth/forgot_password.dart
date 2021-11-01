import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/screens/auth/login.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:cliqlite/utils/text_form.dart';
import 'package:cliqlite/utils/validations.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  static String id = 'forgot_password';

  ForgotPassword({this.user});
  final String user;

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  bool _visible = false;
  bool autoValidate = false;
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerPassword = new TextEditingController();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Validations validations = new Validations();

  bool isFieldsValid() {
    if (_controllerEmail.text.isNotEmpty && _controllerPassword.text.isNotEmpty)
      return true;
    return false;
  }

  nextPage(BuildContext context) async {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autoValidate = true; // Start validating on every change.
    } else {
      try {
        setState(() {
          AuthProvider.auth(context).setIsLoading(true);
        });
        var result = await AuthProvider.auth(context).forgotPassword(
            _controllerEmail.text,
            widget.user == 'parent'
                ? 'auth/parent/forgotpassword'
                : 'auth/user/forgotpassword');

        if (result != null) {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.clear,
                        color: blackColor,
                      ),
                    )
                  ],
                ),
                kLargeHeight,
                Text(
                  'Forgot Password',
                  textAlign: TextAlign.center,
                  style: textStyleSmall.copyWith(
                      fontSize: 21.0,
                      fontWeight: FontWeight.w700,
                      color: primaryColor),
                ),
                kLargeHeight,
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        MyTextForm(
                            controllerName: _controllerEmail,
                            validations: validations.validateEmail,
                            type: TextInputType.text,
                            hintText: 'Email Address'),
                        kLargeHeight,
                        LargeButton(
                          submit: () {
                            nextPage(context);
                          },
                          color: primaryColor,
                          name: 'Forgot Password',
                          buttonColor: secondaryColor,
                          loader: auth.isLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  'Forgot Password',
                                  style: headingWhite.copyWith(
                                    color: secondaryColor,
                                  ),
                                ),
                        ),
                        kSmallHeight,
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TabMenu extends StatelessWidget {
  const TabMenu({this.text, this.onTap, this.decoration, this.style});

  final String text;
  final Function onTap;
  final BoxDecoration decoration;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.only(bottom: 5),
          decoration: decoration,
          child: Text(
            text,
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
