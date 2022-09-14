import 'package:cliqlite/models/auth_model/main_auth_user/main_auth_user.dart';
import 'package:cliqlite/models/child_Index_model/child_index_model.dart';
import 'package:cliqlite/models/subscription_model/subscription_model.dart';
import 'package:cliqlite/models/users_model/users.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/providers/subject_provider/subject_provider.dart';
import 'package:cliqlite/providers/subscription_provider/subscription_provider.dart';
import 'package:cliqlite/providers/theme_provider/theme_provider.dart';
import 'package:cliqlite/screens/account/billing_details/billing_details.dart';
import 'package:cliqlite/screens/account/change_password/change_password.dart';
import 'package:cliqlite/screens/account/edit_chid.dart';
import 'package:cliqlite/screens/account/feedback/feedback.dart';
import 'package:cliqlite/screens/account/manage_payment/manage_payment.dart';
import 'package:cliqlite/screens/account/support/support.dart';
import 'package:cliqlite/screens/auth/login.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/home/make_subscription.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class Account extends StatefulWidget {
  static String id = 'account';
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider theme = ThemeProvider.themeProvider(context);
    List<Users> users = AuthProvider.auth(context).users;
    MainChildUser mainChildUser = AuthProvider.auth(context).mainChildUser;
    ChildIndex childIndex = SubjectProvider.subject(context).index;
    List<Subscription> subscription =
        SubscriptionProvider.subscribe(context).subscription;

    bool test =
        users != null ? users[childIndex?.index ?? 0].test : mainChildUser.test;

    print('testtt: ${test}');

    return BackgroundImage(
      child: SafeArea(
        child: Padding(
          padding: defaultVHPadding.copyWith(bottom: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Account',
                    textAlign: TextAlign.center,
                    style: textStyleSmall.copyWith(
                        fontSize: 21.0,
                        fontWeight: FontWeight.w700,
                        color: primaryColor),
                  ),
                  // profilePicture(context)
                ],
              ),
              Container(
                height: MediaQuery.of(context).size.height / 1.5,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          profilePicture(context, '', size: 70),
                          kSmallWidth,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                ' ${toBeginningOfSentenceCase(users != null ? users[childIndex?.index ?? 0].name.split(' ')[0] : mainChildUser.name.split(' ')[0])}',
                                style: smallAccentColor.copyWith(fontSize: 24),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                softWrap: false,
                              ),
                              kVerySmallHeight,
                              Text(
                                ' ${users != null ? users[childIndex?.index ?? 0].email : mainChildUser.email}',
                                textAlign: TextAlign.center,
                                style: textStyleSmall.copyWith(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400,
                                    color: primaryColor),
                              ),
                            ],
                          )
                        ],
                      ),
                      kLargeHeight,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Text(
                      //       'Enable dark mode',
                      //       style:
                      //           theme.status ? textStyleWhite : textExtraLightBlack,
                      //     ),
                      //     Switch.adaptive(
                      //         value: theme.status,
                      //         activeColor: secondaryColor,
                      //         activeTrackColor: primaryColor,
                      //         inactiveTrackColor: secondaryColor,
                      //         inactiveThumbColor: primaryColor,
                      //         onChanged: (bool value) {
                      //           setState(() {
                      //             theme.setStatus(value);
                      //             if (theme.status) {
                      //               theme.setBackground('assets/images/bg-dark.png');
                      //               theme.toggleMode();
                      //             } else {
                      //               theme.setBackground('assets/images/bg.png');
                      //               theme.toggleMode();
                      //             }
                      //           });
                      //         })
                      //   ],
                      // ),
                      // SizedBox(height: 30.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Personal Settings',
                            style: smallPrimaryColor.copyWith(
                                fontSize: 17, fontWeight: FontWeight.w600),
                          ),
                          Divider(
                            height: 50,
                            thickness: 1,
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditChildDetails())),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/svg/settings-1.svg',
                                      color: primaryColor,
                                    ),
                                    kVerySmallWidth,
                                    Text("Edit child's details",
                                        style: smallPrimaryColor),
                                  ],
                                ),
                                Icon(
                                  Icons.chevron_right,
                                  color: theme.status ? whiteColor : blackColor,
                                )
                              ],
                            ),
                          ),
                          Divider(
                            height: 50,
                            thickness: 1,
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ChangePassword())),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/svg/settings-2.svg',
                                      color: primaryColor,
                                    ),
                                    kVerySmallWidth,
                                    Text(
                                      "Change Password",
                                      style: smallPrimaryColor,
                                    ),
                                  ],
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
                      Divider(
                        height: 50,
                        thickness: 1,
                      ),
                      if (!test)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Account Settings',
                              style: smallPrimaryColor.copyWith(
                                  fontSize: 17, fontWeight: FontWeight.w600),
                            ),
                            Divider(
                              height: 50,
                              thickness: 1,
                            ),

                            // (subscription?.isEmpty ?? false)
                            //     ? Container()
                            //     :
                            Column(
                              children: [
                                InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BillingDetails())),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          SvgPicture.asset(
                                            'assets/images/svg/settings-3.svg',
                                            color: primaryColor,
                                          ),
                                          kVerySmallWidth,
                                          Text(
                                            "Billing Details",
                                            style: smallPrimaryColor,
                                          ),
                                        ],
                                      ),
                                      Icon(
                                        Icons.chevron_right,
                                        color: theme.status
                                            ? whiteColor
                                            : blackColor,
                                      )
                                    ],
                                  ),
                                ),
                                Divider(
                                  height: 50,
                                  thickness: 1,
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ManagePayoutInfo())),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/svg/settings-4.svg',
                                        color: primaryColor,
                                      ),
                                      kVerySmallWidth,
                                      Text(
                                        "Manage payout info",
                                        style: smallPrimaryColor,
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color:
                                        theme.status ? whiteColor : blackColor,
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 50,
                              thickness: 1,
                            ),
                            InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          MakeSubscription())),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/svg/settings-5.svg',
                                        color: primaryColor,
                                      ),
                                      kVerySmallWidth,
                                      Text(
                                        "Subscription",
                                        style: smallPrimaryColor,
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color:
                                        theme.status ? whiteColor : blackColor,
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 50,
                              thickness: 1,
                            ),
                            // InkWell(
                            //   onTap: () => Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (context) => UsageLimit())),
                            //   child: Row(
                            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Row(
                            //         children: [
                            //           SvgPicture.asset(
                            //               'assets/images/svg/settings-6.svg'),
                            //           kVerySmallWidth,
                            //           Text(
                            //             "Set app usage timer",
                            //             style: smallPrimaryColor,
                            //           ),
                            //         ],
                            //       ),
                            //       Icon(
                            //         Icons.chevron_right,
                            //         color: theme.status ? whiteColor : blackColor,
                            //       )
                            //     ],
                            //   ),
                            // ),
                            // Divider(
                            //   height: 50,
                            //   thickness: 1,
                            // ),
                            InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FeedBackScreen())),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/svg/settings-7.svg',
                                        color: primaryColor,
                                      ),
                                      kVerySmallWidth,
                                      Text(
                                        "Feedback",
                                        style: smallPrimaryColor,
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color:
                                        theme.status ? whiteColor : blackColor,
                                  )
                                ],
                              ),
                            ),
                            Divider(
                              height: 50,
                              thickness: 1,
                            ),
                            InkWell(
                              onTap: () =>
                                  Navigator.pushNamed(context, Support.id),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        'assets/images/svg/settings-8.svg',
                                        color: primaryColor,
                                      ),
                                      kVerySmallWidth,
                                      Text(
                                        "Support",
                                        style: smallPrimaryColor,
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color:
                                        theme.status ? whiteColor : blackColor,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      kLargeHeight,
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  await AuthProvider.auth(context).logout();
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Login.id, (Route<dynamic> route) => false);
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 21),
                  decoration: BoxDecoration(
                      color: lightPrimaryColor,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: accentColor, width: 0.5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Log out',
                        textAlign: TextAlign.center,
                        style: smallPrimaryColor,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
