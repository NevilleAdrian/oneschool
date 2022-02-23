import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:cliqlite/utils/text_form.dart';
import 'package:cliqlite/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  //Global Key
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  //Validation
  Validations validations = new Validations();

  //Controllers
  TextEditingController _oldPassword = new TextEditingController();
  TextEditingController _newPassword = new TextEditingController();
  TextEditingController _confirmPassword = new TextEditingController();

  //visibility
  bool _oldVisible = true;
  bool _newVisible = true;
  bool _confirmVisible = true;

  //validation boolean
  bool autoValidate = false;

  //Route to next page
  nextPage() async {
    final FormState form = formKey.currentState;
    AuthProvider auth = AuthProvider.auth(context);
    if (!form.validate()) {
      autoValidate = true; // Start validating on every change.
    } else {
      if (_newPassword.text == _confirmPassword.text) {
        try {
          setState(() {
            auth.setIsLoading(true);
          });
          var result;
          if (auth.user.role == 'parent') {
            result = await auth.changePassword(_oldPassword.text,
                _confirmPassword.text, 'auth/parent/updatepassword');
          } else {
            result = await auth.changePassword(_oldPassword.text,
                _confirmPassword.text, 'auth/user/updatepassword');
          }
          if (result != null) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AppLayout(
                          index: 3,
                        )));
            showFlush(context, 'Successfully Changed Password', primaryColor);

            setState(() {
              auth.setIsLoading(false);
            });
          }
        } catch (ex) {
          showFlush(context, ex.toString(), primaryColor);
          setState(() {
            auth.setIsLoading(false);
          });
        }
      } else {
        showFlush(context, "Password don't match", primaryColor);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider auth = AuthProvider.auth(context);

    return BackgroundImage(
      child: SafeArea(
        child: Padding(
          padding: defaultVHPadding,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () => Navigator.pop(context),
                      child: Icon(
                        Icons.chevron_left,
                        color: blackColor,
                      )),
                  Text(
                    "Change Password",
                    textAlign: TextAlign.center,
                    style: textStyleSmall.copyWith(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w700,
                        color: primaryColor),
                  ),
                  Container()
                ],
              ),
              kLargeHeight,
              Form(
                  key: formKey,
                  child: Column(
                    children: [
                      MyTextForm(
                        controllerName: _oldPassword,
                        validations: validations.validatePassword,
                        obscureText: _oldVisible,
                        area: 1,
                        hintText: 'Old Password',
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _oldVisible = !_oldVisible;
                              });
                            },
                            child: Container(
                              width: 20.0,
                              padding: EdgeInsets.only(right: 15),
                              alignment: Alignment.centerRight,
                              child: _oldVisible
                                  ? SvgPicture.asset(
                                      'assets/images/svg/eye-off.svg')
                                  : SvgPicture.asset(
                                      'assets/images/svg/eye.svg'),
                            )),
                      ),
                      kSmallHeight,
                      MyTextForm(
                        controllerName: _newPassword,
                        validations: validations.validatePassword,
                        obscureText: _newVisible,
                        area: 1,
                        hintText: 'New Password',
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _newVisible = !_newVisible;
                              });
                            },
                            child: Container(
                              width: 20.0,
                              padding: EdgeInsets.only(right: 15),
                              alignment: Alignment.centerRight,
                              child: _newVisible
                                  ? SvgPicture.asset(
                                      'assets/images/svg/eye-off.svg')
                                  : SvgPicture.asset(
                                      'assets/images/svg/eye.svg'),
                            )),
                      ),
                      kSmallHeight,
                      MyTextForm(
                        controllerName: _confirmPassword,
                        validations: validations.validatePassword,
                        obscureText: _confirmVisible,
                        area: 1,
                        hintText: 'Confirm New Password',
                        suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                _confirmVisible = !_confirmVisible;
                              });
                            },
                            child: Container(
                              width: 20.0,
                              padding: EdgeInsets.only(right: 15),
                              alignment: Alignment.centerRight,
                              child: _confirmVisible
                                  ? SvgPicture.asset(
                                      'assets/images/svg/eye-off.svg')
                                  : SvgPicture.asset(
                                      'assets/images/svg/eye.svg'),
                            )),
                      ),
                      kLargeHeight,
                      GreenButton(
                        submit: () => nextPage(),
                        color: primaryColor,
                        name: 'Save Changes',
                        loader: auth.isLoading,
                        buttonColor: secondaryColor,
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
