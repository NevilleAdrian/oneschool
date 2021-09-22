import 'package:flutter/material.dart';

TextStyle textStyle = const TextStyle(
  color: const Color(0XFF000000),
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
  fontFamily: "Montserrat",
);

TextStyle redTextStyle = const TextStyle(
  color: Colors.red,
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  fontFamily: "Montserrat",
);

TextStyle textStyleWhite = const TextStyle(
  color: const Color(0XFFFFFFFF),
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
  fontFamily: "Montserrat",
);

TextStyle textExtraLightBlack = const TextStyle(
  color: const Color(0XFF000000),
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  fontFamily: "Montserrat",
);

TextStyle textLightBlack = const TextStyle(
  color: const Color(0XFF000000),
  fontSize: 15.0,
  fontWeight: FontWeight.w600,
  fontFamily: "Montserrat",
);

TextStyle textBoldBlack = const TextStyle(
  color: const Color(0XFF000000),
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  fontFamily: "Montserrat",
);

TextStyle textBoldWhite = const TextStyle(
  color: const Color(0XFFFFFFFF),
  fontSize: 10.0,
  fontWeight: FontWeight.bold,
  fontFamily: "Montserrat",
);

TextStyle textBlackItalic = const TextStyle(
  color: const Color(0XFF000000),
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
  fontStyle: FontStyle.italic,
  fontFamily: "Montserrat",

  //
);

TextStyle textGrey = const TextStyle(
  color: Colors.grey,
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
  fontFamily: "Montserrat",
);

TextStyle textGreyBold = const TextStyle(
  color: Colors.grey,
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  fontFamily: "Montserrat",
);

TextStyle textStyleBlue = const TextStyle(
  color: primaryColor,
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
  fontFamily: "Montserrat",
);

TextStyle textStyleActive = const TextStyle(
  color: const Color(0xFFF44336),
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
  fontFamily: "Montserrat",
);

TextStyle textStyleValidate = const TextStyle(
  color: const Color(0xFFF44336),
  fontSize: 11.0,
  fontWeight: FontWeight.normal,
  fontStyle: FontStyle.italic,
  fontFamily: "Montserrat",
);

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith(
    title: base.title.copyWith(
      fontFamily: "Montserrat",
    ),
  );
}

TextStyle textGreen = const TextStyle(
  color: const Color(0xFF00c497),
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
  fontFamily: "Montserrat",
);

final ThemeData base = ThemeData.light();

ThemeData appTheme = new ThemeData(
  primaryColor: primaryColor,
  buttonColor: primaryColor,
  indicatorColor: Colors.white,
  fontFamily: "Montserrat",
  splashColor: Colors.white24,
  splashFactory: InkRipple.splashFactory,
  accentColor: accentColor,
  canvasColor: Colors.white,
  scaffoldBackgroundColor: backgroundColor,
  backgroundColor: backgroundColor,
  errorColor: const Color(0xFFB00020),
  iconTheme: new IconThemeData(color: primaryColor),
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
  ),
  textTheme: _buildTextTheme(base.textTheme),
  primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
  accentTextTheme: _buildTextTheme(base.accentTextTheme),
);

Color textFieldColor = const Color.fromRGBO(168, 160, 149, 0.6);
const Color whiteColor = const Color(0XFFFFFFFF);
const Color backgroundColor = const Color(0XFFFDFDF8);
const Color blackColor = const Color(0XFF242A37);
const Color disabledColor = const Color(0XFFF7F8F9);
const Color greyColor = Colors.grey;
Color greyColor2 = Colors.grey.withOpacity(0.3);
const Color activeColor = const Color(0xFFF44336);
const Color redColor = const Color(0xFFFF0000);
const Color buttonStop = const Color(0xFFF44336);
const Color primaryColor = const Color(0xFF016F56);
const Color accentColor = const Color(0xFFB4C304);
const Color splashBgColor = const Color(0xFF00008B);
const Color secondaryColor = const Color(0xFFB4C304);
const Color facebook = const Color(0xFF4267b2);
const Color googlePlus = const Color(0xFFdb4437);
const Color yellow = Colors.pinkAccent;
const Color green1 = Colors.lightGreen;
const Color green2 = Colors.green;
const Color blueColor = Color(0xFF02BEFD);

const Color greenColor = const Color(0xFF00c497);
//const Color greyColor = Colors.grey;

TextStyle textStyleSmall = const TextStyle(
    color: const Color.fromRGBO(255, 255, 255, 0.8),
    fontSize: 12.0,
    fontFamily: "Montserrat",
    fontWeight: FontWeight.bold);

BoxDecoration decoration = BoxDecoration(
  color: Colors.transparent,
  border: Border.all(width: 0.6, color: greyColor),
  borderRadius: BorderRadius.circular(20),
);

EdgeInsets defaultPadding = const EdgeInsets.symmetric(horizontal: 20);
EdgeInsets defaultVHPadding =
    const EdgeInsets.symmetric(horizontal: 20, vertical: 40);

TextStyle headingWhite = new TextStyle(
  color: Colors.white,
  fontSize: 17.0,
  fontWeight: FontWeight.bold,
  fontFamily: "Montserrat",
);

TextStyle headingWhite18 = new TextStyle(
  color: Colors.white,
  fontSize: 18.0,
  fontWeight: FontWeight.normal,
  fontFamily: "Montserrat",
);

TextStyle headingRed = new TextStyle(
  color: redColor,
  fontSize: 22.0,
  fontWeight: FontWeight.normal,
  fontFamily: "Montserrat",
);

TextStyle headingGrey = new TextStyle(
  color: Colors.grey,
  fontSize: 22.0,
  fontWeight: FontWeight.normal,
  fontFamily: "Montserrat",
);

TextStyle heading18 = new TextStyle(
  color: Colors.white,
  fontSize: 14.0,
  fontWeight: FontWeight.normal,
  fontFamily: "Montserrat",
);

TextStyle heading18Black = new TextStyle(
  color: blackColor,
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  fontFamily: "Montserrat",
);

TextStyle headingBlack = new TextStyle(
  color: blackColor,
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
  fontFamily: "Montserrat",
);

TextStyle headingPrimaryColor = new TextStyle(
  color: primaryColor,
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
  fontFamily: "Montserrat",
);

TextStyle smallPrimaryColor = new TextStyle(
  color: primaryColor,
  fontSize: 14.0,
  // fontWeight: FontWeight.w400,
  fontFamily: "Montserrat",
);

TextStyle headingSmallGreyColor = new TextStyle(
  color: Color(0XFF999CAD),
  fontSize: 12.0,
  fontWeight: FontWeight.w400,
  fontFamily: "Montserrat",
);

TextStyle headingLogo = new TextStyle(
  color: blackColor,
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
  fontFamily: "Montserrat",
);

TextStyle heading35 = new TextStyle(
  color: Colors.white,
  fontSize: 35.0,
  fontWeight: FontWeight.bold,
  fontFamily: "Montserrat",
);

TextStyle heading35Black = new TextStyle(
  color: primaryColor,
  fontSize: 30.0,
  fontWeight: FontWeight.w700,
  fontFamily: "Montserrat",
);

SizedBox kSmallWidth = SizedBox(width: 20.0);
SizedBox kSmallHeight = SizedBox(height: 20.0);
SizedBox kLargeHeight = SizedBox(height: 50.0);

const Color transparentColor = const Color.fromRGBO(0, 0, 0, 0.2);
const Color activeButtonColor = const Color.fromRGBO(43, 194, 137, 50.0);
const Color dangerButtonColor = const Color(0XFFf53a4d);

int getColorHexFromStr(String colorStr) {
  colorStr = "FF" + colorStr;
  colorStr = colorStr.replaceAll("#", "");
  int val = 0;
  int len = colorStr.length;
  for (int i = 0; i < len; i++) {
    int hexDigit = colorStr.codeUnitAt(i);
    if (hexDigit >= 48 && hexDigit <= 57) {
      val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 65 && hexDigit <= 70) {
      // A..F
      val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 97 && hexDigit <= 102) {
      // a..f
      val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
    } else {
      throw new FormatException("An error occurred when converting a color");
    }
  }
  return val;
}

// void showFlush(BuildContext context, String message, Color color) {
//   Flushbar(
//     backgroundColor: color,
//     message: message,
//     duration: Duration(seconds: 7),
//     flushbarStyle: FlushbarStyle.GROUNDED,
//   ).show(context);
// }
