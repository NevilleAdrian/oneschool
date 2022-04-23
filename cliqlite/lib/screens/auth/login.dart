import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
import 'package:cliqlite/models/quiz_active/quiz_active.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/quiz_provider/quiz_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/repository/hive_repository.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/auth/forgot_password.dart';
import 'package:cliqlite/screens/auth/verify_account.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/get_started/get_started.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/constants.dart';
import 'package:cliqlite/utils/have_account.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:cliqlite/utils/text_form.dart';
import 'package:cliqlite/utils/top_bar.dart';
import 'package:cliqlite/utils/validations.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  static String id = 'Login';
  @override
  _LoginState createState() => _LoginState();
}

enum Type { parent, child }

class _LoginState extends State<Login> {
  Type type = Type.parent;
  bool _visible = true;
  bool autoValidate = false;
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerPassword = new TextEditingController();
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Validations validations = new Validations();
  HiveRepository _hiveRepository = HiveRepository();

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

            ChildIndex childIndex = ChildIndex.fromJson({"index": 0});
            QuizActive quizActive = QuizActive.fromJson({"active": true});

            //set bool
            SubjectProvider.subject(context).setIndex(childIndex);
            QuizProvider.quizProvider(context).setQuizActive(quizActive);

            //Save status in hive
            _hiveRepository.add<ChildIndex>(
                name: kIndex, key: 'index', item: childIndex);
            _hiveRepository.add<QuizActive>(
                name: kQuizActive, key: 'quizActive', item: quizActive);

            print('${QuizProvider.quizProvider(context).quizActive}');
            print('${SubjectProvider.subject(context).index.index}');
          });
        }
      } catch (ex) {
        showFlush(context, ex.toString(), primaryColor);

        if (ex.toString() ==
            'Sorry kindly verify your account before logging in.') {
          print("hye it's me");
          var result =
              await AuthProvider.auth(context).resendOtp(_controllerEmail.text);
          if (result != null) {
            setState(() {
              AuthProvider.auth(context).setIsLoading(false);
            });
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => VerifyAccount(
                          email: _controllerEmail.text,
                        )));
          }
        } else {
          setState(() {
            AuthProvider.auth(context).setIsLoading(false);
          });
        }
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
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     InkWell(
                //       onTap: () => Navigator.pushNamed(context, GetStarted.id),
                //       child: Icon(
                //         Icons.clear,
                //         color: blackColor,
                //       ),
                //     )
                //   ],
                // ),
                // kLargeHeight,
                TopBar(
                  text: 'Log in',
                ),
                // Text(
                //   'Log in',
                //   textAlign: TextAlign.center,
                //   style: textStyleSmall.copyWith(
                //       fontSize: 21.0,
                //       fontWeight: FontWeight.w700,
                //       color: primaryColor),
                // ),
                kLargeHeight,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TabMenu(
                      text: 'As a Parent',
                      style: type == Type.parent
                          ? smallPrimaryColor.copyWith(fontSize: 18)
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
                          ? smallPrimaryColor.copyWith(fontSize: 18)
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
                                    ? Text(
                                        'Show',
                                        style: smallAccentColor,
                                      )
                                    : Text(
                                        'Hide',
                                        style: smallAccentColor,
                                      ),
                              )),
                        ),
                        kSmallHeight,
                        InkWell(
                          onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPassword(
                                        user: type == Type.parent
                                            ? 'parent'
                                            : 'child',
                                      ))),
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
                        GreenButton(
                          submit: () {
                            nextPage(context);
                          },
                          color: primaryColor,
                          name: 'Log In',
                          buttonColor: secondaryColor,
                          loader: auth.isLoading,
                        ),
                        kSmallHeight,
                        // type == Type.parent
                        //     ? Row(
                        //         children: [
                        //           Expanded(
                        //             child: Divider(
                        //               color: greyColor,
                        //               thickness: 0.5,
                        //             ),
                        //           ),
                        //           kSmallWidth,
                        //           Text(
                        //             'or login with',
                        //             style: textExtraLightBlack,
                        //           ),
                        //           kSmallWidth,
                        //           Expanded(
                        //             child: Divider(
                        //               color: greyColor,
                        //               thickness: 0.5,
                        //             ),
                        //           ),
                        //         ],
                        //       )
                        //     : Container(),
                        // kSmallHeight,
                        // type == Type.parent
                        //     ? GoogleButton(
                        //         text: 'Log in with Google',
                        //       )
                        //     : Container(),
                        // type == Type.parent ? kLargeHeight :
                        kSmallHeight,

                        HaveAccount(
                          text: "Don't have an account?",
                          subText: " Sign Up",
                          onPressed: () =>
                              Navigator.pushNamed(context, GetStarted.id),
                        ),
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
