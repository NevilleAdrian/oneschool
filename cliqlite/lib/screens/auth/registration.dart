import 'package:cliqlite/screens/auth/child_registration.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/get_started/get_started.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:cliqlite/utils/google_button.dart';
import 'package:cliqlite/utils/have_account.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/text_form.dart';
import 'package:cliqlite/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Registration extends StatefulWidget {
  static String id = 'registration';
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final GlobalKey<FormState> formKey = new GlobalKey<FormState>();
  Validations validations = new Validations();
  TextEditingController _controllerName = new TextEditingController();
  TextEditingController _controllerEmail = new TextEditingController();
  TextEditingController _controllerPhone = new TextEditingController();
  TextEditingController _controllerPassword = new TextEditingController();
  bool _visible = true;
  bool autoValidate = false;

  nextPage() {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autoValidate = true; // Start validating on every change.
    } else {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ChildRegistration(
                    fullName: _controllerName.text,
                    email: _controllerEmail.text,
                    phoneNo: _controllerPhone.text,
                    password: _controllerPassword.text,
                  )));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: defaultVHPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BackArrow(
                  onTap: () => Navigator.pushNamed(context, GetStarted.id),
                ),
                kSmallHeight,
                Text(
                  '01/02',
                  style: textLightBlack.copyWith(
                      fontSize: 18, fontWeight: FontWeight.w400),
                ),
                kSmallHeight,
                Text(
                  'Fill in your personal details',
                  textAlign: TextAlign.center,
                  style: textStyleSmall.copyWith(
                      fontSize: 21.0,
                      fontWeight: FontWeight.w700,
                      color: primaryColor),
                ),
                kSmallHeight,
                Form(
                    key: formKey,
                    child: Column(
                      children: [
                        MyTextForm(
                          controllerName: _controllerName,
                          validations: validations.validateName,
                          hintText: 'Full Name',
                        ),
                        kSmallHeight,
                        MyTextForm(
                          controllerName: _controllerEmail,
                          validations: validations.validateEmail,
                          hintText: 'Email Address',
                        ),
                        kSmallHeight,
                        MyTextForm(
                          controllerName: _controllerPhone,
                          validations: validations.validateMobile,
                          hintText: 'Phone Number',
                          type: TextInputType.phone,
                        ),
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
                        LargeButton(
                          submit: () => nextPage(),
                          color: primaryColor,
                          name: 'Next',
                          buttonColor: secondaryColor,
                        ),
                        kSmallHeight,
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: greyColor,
                                thickness: 0.5,
                              ),
                            ),
                            kSmallWidth,
                            Text(
                              'or sign up with',
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
                        ),
                        kSmallHeight,
                        GoogleButton(),
                        kSmallHeight,
                        HaveAccount()
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
