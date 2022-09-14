import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/screens/app_layout/applayout.dart';
import 'package:cliqlite/screens/auth/recover_password.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/back_arrow.dart';
import 'package:cliqlite/utils/large_button.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pinput/pin_put/pin_put.dart';

class VerifyAccount extends StatefulWidget {
  static String id = 'verify-account';

  VerifyAccount({this.type, this.email, this.url});
  final String type;
  final String email;
  final String url;

  @override
  _VerifyAccountState createState() => _VerifyAccountState();
}

class _VerifyAccountState extends State<VerifyAccount> {
  final _pinController = TextEditingController();
  final _pinFocusNode = FocusNode();
  final _pinPageController = PageController();

  int _pinPageIndex = 0;

  final List<Widget> _pin = [];

  pin() {
    final BoxDecoration pinPutDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      border: Border.all(
        width: 1,
        color: primaryColor,
      ),
    );
    return PinPut(
      eachFieldWidth: 45.0,
      eachFieldHeight: 62.0,
      withCursor: true,
      fieldsCount: 6,
      obscureText: '*',
      focusNode: _pinFocusNode,
      controller: _pinController,
      // onSubmit: (String pin) => _showSnackBar(pin),
      submittedFieldDecoration: pinPutDecoration,
      selectedFieldDecoration: pinPutDecoration,
      followingFieldDecoration: pinPutDecoration,
      pinAnimationType: PinAnimationType.scale,
      textStyle: const TextStyle(color: primaryColor, fontSize: 20.0),
    );
  }

  nextPage() async {
    print('pin:${_pinController.text}');
    if (widget.type == 'forgot') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => RecoverPassword(
                    token: _pinController.text,
                  )));
    } else {
      setState(() {
        AuthProvider.auth(context).setIsLoading(true);
      });
      try {
        var data = await AuthProvider.auth(context)
            .verifyAccount(int.parse(_pinController.text), url: widget.url);
        if (data != null) {
          setState(() {
            AuthProvider.auth(context).setIsLoading(false);
          });
          showFlush(context, 'Account Successfully Verified', primaryColor);
          Navigator.pushNamed(context, AppLayout.id);
        }
      } catch (ex) {
        print('ex:$ex');
        setState(() {
          AuthProvider.auth(context).setIsLoading(false);
        });
        showFlush(context, '${ex.toString()}', primaryColor);
      }
    }
  }

  resendOTP() async {
    var result = await AuthProvider.auth(context).resendOtp(widget.email);
    if (result != null) {
      showFlush(context, 'OTP has been sent to your email', primaryColor);
    }
  }

  @override
  void initState() {
    print('widget: ${widget.type}');
    print('email: ${widget.email}');
    print('email: ${widget.url}');
    _pin.addAll([
      pin(),
    ]);
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _pinFocusNode.dispose();
    _pinController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
        child: SingleChildScrollView(
            child: SafeArea(
      child: Padding(
        padding: defaultPadding,
        child: Column(
          children: [
            BackArrow(
              text: widget.type == 'forgot'
                  ? 'Recover Password'
                  : 'Verify your phone number',
            ),
            kSmallHeight,
            widget.type != 'forgot'
                ? LinearPercentIndicator(
                    lineHeight: 5.0,
                    percent: 1,
                    progressColor: primaryColor,
                  )
                : Container(),
            widget.type != 'forgot' ? kLargeHeight : kSmallHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Enter the 6-digit pin that was sent to your email.',
                  style: smallPrimaryColor,
                )
              ],
            ),
            Container(
              height: 150.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      child: PageView(
                        scrollDirection: Axis.vertical,
                        controller: _pinPageController,
                        onPageChanged: (index) {
                          setState(() => _pinPageIndex = index);
                        },
                        children: _pin.map((p) {
                          return FractionallySizedBox(
                            heightFactor: 1.0,
                            child: Center(child: p),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            kSmallHeight,
            GreenButton(
              submit: () => nextPage(),
              color: primaryColor,
              name: widget.type == 'forgot' ? 'Next' : 'Verify',
              loader: AuthProvider.auth(context).isLoading,
              buttonColor: secondaryColor,
            ),
            kSmallHeight,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () => resendOTP(),
                    child: Text('Resend OTP', style: smallAccentColor))
              ],
            )
          ],
        ),
      ),
    )));
  }
}
