import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/screens/auth/child_registration.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/have_account.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:cliqlite/utils/text_form.dart';
import 'package:cliqlite/utils/top_bar.dart';
import 'package:cliqlite/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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

  nextPage() async {
    final FormState form = formKey.currentState;
    if (!form.validate()) {
      autoValidate = true; // Start validating on every change.
    } else {
      try {
        setState(() {
          AuthProvider.auth(context).setIsLoading(true);
        });
        var result;
        result = await AuthProvider.auth(context).getGrades();
        if (result != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChildRegistration(
                        fullName: _controllerName.text,
                        email: _controllerEmail.text,
                        phoneNo: _controllerPhone.text,
                        password: _controllerPassword.text,
                        type: 'parent',
                      )));
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
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TopBar(
                  text: 'Personal details',
                ),
                kSmallHeight,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LinearPercentIndicator(
                      lineHeight: 5.0,
                      percent: 0.5,
                      progressColor: Color(0xFF09AC2C),
                    ),
                  ],
                ),
                kLargeHeight,
                Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MyTextForm(
                          controllerName: _controllerName,
                          validations: validations.validateName,
                          hintText: 'Name',
                        ),
                        kSmallHeight,
                        MyTextForm(
                          controllerName: _controllerEmail,
                          validations: validations.validateEmail,
                          hintText: 'Email',
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
                        GreenButton(
                          submit: () => nextPage(),
                          color: primaryColor,
                          name: 'Sign Up',
                          loader: auth.isLoading,
                        ),
                        kSmallHeight,
                        // Row(
                        //   children: [
                        //     Expanded(
                        //       child: Divider(
                        //         color: greyColor,
                        //         thickness: 0.5,
                        //       ),
                        //     ),
                        //     kSmallWidth,
                        //     Text(
                        //       'or sign up with',
                        //       style: textExtraLightBlack,
                        //     ),
                        //     kSmallWidth,
                        //     Expanded(
                        //       child: Divider(
                        //         color: greyColor,
                        //         thickness: 0.5,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // kSmallHeight,
                        // GoogleButton(),
                        // kSmallHeight,
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
