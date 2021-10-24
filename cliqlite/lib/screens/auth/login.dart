import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/auth/forgot_password.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/get_started/get_started.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/google_button.dart';
import 'package:cliqlite/utils/have_account.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:cliqlite/utils/text_form.dart';
import 'package:cliqlite/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Login extends StatefulWidget {
  static String id = 'Login';
  @override
  _LoginState createState() => _LoginState();
}

enum Type { parent, child }

class _LoginState extends State<Login> {
  Type type = Type.parent;
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
        var result;
        if (type == Type.parent) {
          result = await AuthProvider.auth(context).loginUser(
              _controllerEmail.text,
              _controllerPassword.text,
              'auth/parent/login',
              'parent');
        } else {
          result = await AuthProvider.auth(context).loginUser(
              _controllerEmail.text,
              _controllerPassword.text,
              'auth/user/login',
              'user');
        }
        if (result != null) {
          Navigator.pushNamed(context, AppLayout.id);
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
                  'Log in',
                  textAlign: TextAlign.center,
                  style: textStyleSmall.copyWith(
                      fontSize: 21.0,
                      fontWeight: FontWeight.w700,
                      color: primaryColor),
                ),
                kLargeHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TabMenu(
                      text: 'As a Parent',
                      style: type == Type.parent
                          ? heading18Black
                          : headingBigGreyColor,
                      onTap: () {
                        setState(() {
                          type = Type.parent;
                          _controllerEmail.clear();
                          _controllerPassword.clear();
                        });
                      },
                      decoration: BoxDecoration(
                          border: type == Type.parent
                              ? Border(
                                  bottom: BorderSide(
                                      width: 1.8, color: primaryColor))
                              : Border(bottom: BorderSide.none)),
                    ),
                    kSmallWidth,
                    TabMenu(
                      text: 'As a Child',
                      style: type == Type.child
                          ? heading18Black
                          : headingBigGreyColor,
                      onTap: () {
                        setState(() {
                          type = Type.child;
                          _controllerEmail.clear();
                          _controllerPassword.clear();
                        });
                      },
                      decoration: BoxDecoration(
                          border: type == Type.child
                              ? Border(
                                  bottom: BorderSide(
                                      width: 1.8, color: primaryColor))
                              : Border(bottom: BorderSide.none)),
                    ),
                  ],
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
                        kSmallHeight,
                        MyTextForm(
                          controllerName: _controllerPassword,
                          validations: validations.validatePassword,
                          obscureText: _visible,
                          area: 1,
                          hintText: 'Password',
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  _visible = !_visible;
                                });
                              },
                              child: Container(
                                width: 20.0,
                                padding: EdgeInsets.only(right: 15),
                                alignment: Alignment.centerRight,
                                child: _visible
                                    ? SvgPicture.asset(
                                        'assets/images/svg/eye-off.svg')
                                    : SvgPicture.asset(
                                        'assets/images/svg/eye.svg'),
                              )),
                        ),
                        kSmallHeight,
                        InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context, ForgotPassword.id),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                'Forgot Password?',
                                style: heading18.copyWith(color: blackColor),
                              )
                            ],
                          ),
                        ),
                        kLargeHeight,
                        LargeButton(
                          submit: () {
                            nextPage(context);
                          },
                          color: primaryColor,
                          name: 'Log In',
                          buttonColor: secondaryColor,
                          loader: auth.isLoading
                              ? CircularProgressIndicator()
                              : Text(
                                  'Log In',
                                  style: headingWhite.copyWith(
                                    color: secondaryColor,
                                  ),
                                ),
                        ),
                        kSmallHeight,
                        type == Type.parent
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      color: greyColor,
                                      thickness: 0.5,
                                    ),
                                  ),
                                  kSmallWidth,
                                  Text(
                                    'or login with',
                                    style: textExtraLightBlack,
                                  ),
                                  kSmallWidth,
                                  Expanded(
                                    child: Divider(
                                      color: greyColor,
                                      thickness: 0.5,
                                    ),
                                  ),
                                ],
                              )
                            : Container(),
                        kSmallHeight,
                        type == Type.parent
                            ? GoogleButton(
                                text: 'Log in with Google',
                              )
                            : Container(),
                        type == Type.parent ? kLargeHeight : kSmallHeight,
                        HaveAccount(
                          text: "Don't have an account?",
                          subText: " Sign Up",
                          onPressed: () =>
                              Navigator.pushNamed(context, GetStarted.id),
                        )
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
