import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:cliqlite/screens/account/billing_details/billing_details.dart';
import 'package:cliqlite/screens/account/change_password/change_password.dart';
import 'package:cliqlite/screens/account/edit_chid.dart';
import 'package:cliqlite/screens/auth/login.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/dialog_box.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = ThemeProvider.themeProvider(context);

    return BackgroundImage(
      child: SafeArea(
        child: Padding(
          padding: defaultVHPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Account',
                    textAlign: TextAlign.center,
                    style: textStyleSmall.copyWith(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w700,
                        color: theme.status ? secondaryColor : primaryColor),
                  ),
                  InkWell(
                    onTap: () => onTap(context),
                    child: Image.asset(
                      'assets/images/picture.png',
                    ),
                  ),
                ],
              ),
              kSmallHeight,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Enable dark mode',
                    style: theme.status ? textStyleWhite : textExtraLightBlack,
                  ),
                  Switch.adaptive(
                      value: theme.status,
                      activeColor: secondaryColor,
                      activeTrackColor: primaryColor,
                      inactiveTrackColor: secondaryColor,
                      inactiveThumbColor: primaryColor,
                      onChanged: (bool value) {
                        setState(() {
                          theme.setStatus(value);
                          if (theme.status) {
                            theme.setBackground('assets/images/bg-dark.png');
                            theme.toggleMode();
                          } else {
                            theme.setBackground('assets/images/bg.png');
                            theme.toggleMode();
                          }
                        });
                      })
                ],
              ),
              SizedBox(height: 30.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Personal Settings',
                    style: theme.status
                        ? textStyleWhite.copyWith(fontWeight: FontWeight.w600)
                        : textLightBlack,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditChildDetails())),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Edit Child's Details",
                          style: theme.status
                              ? textStyleWhite
                              : textExtraLightBlack,
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: theme.status ? whiteColor : blackColor,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ChangePassword())),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Change Password",
                          style: theme.status
                              ? textStyleWhite
                              : textExtraLightBlack,
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: theme.status ? whiteColor : blackColor,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'My Referral Code',
                    style: theme.status
                        ? textStyleWhite.copyWith(fontWeight: FontWeight.w600)
                        : textLightBlack,
                  ),
                  kSmallHeight,
                  Text(
                    'NJKIE48290',
                    style: theme.status ? textStyleWhite : textExtraLightBlack,
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Account Settings',
                    style: theme.status
                        ? textStyleWhite.copyWith(fontWeight: FontWeight.w600)
                        : textLightBlack,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Manage Payment Info",
                        style:
                            theme.status ? textStyleWhite : textExtraLightBlack,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: theme.status ? whiteColor : blackColor,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => BillingDetails())),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Billing Details",
                          style: theme.status
                              ? textStyleWhite
                              : textExtraLightBlack,
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: theme.status ? whiteColor : blackColor,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Support",
                        style:
                            theme.status ? textStyleWhite : textExtraLightBlack,
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: theme.status ? whiteColor : blackColor,
                      )
                    ],
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              InkWell(
                onTap: () async {
                  await AuthProvider.auth(context).logout();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Login.id, (Route<dynamic> route) => false);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Log out',
                      textAlign: TextAlign.center,
                      style: theme.status
                          ? textStyleWhite.copyWith(fontWeight: FontWeight.w600)
                          : textLightBlack,
                    ),
                    Icon(
                      Icons.logout,
                      color: theme.status ? secondaryColor : primaryColor,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
