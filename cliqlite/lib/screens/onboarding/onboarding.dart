import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/get_started/get_started.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatefulWidget {
  static String id = 'screens.onboarding';

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageViewController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Center(
                child: PageView(
                  controller: pageViewController,
                  onPageChanged: (page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    OnboardItem(
                      image: "assets/images/svg/onboarding-1.svg",
                      title: "Lorem Ipsum Dolor",
                      description:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tortor.",
                    ),
                    OnboardItem(
                      image: "assets/images/svg/onboarding-3.svg",
                      title: "Lorem Ipsum Dolor",
                      description:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tortor.",
                    ),
                    OnboardItem(
                      image: "assets/images/svg/onboarding-2.svg",
                      title: "Lorem Ipsum Dolor",
                      description:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tortor.",
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      PageNavIndicator(
                        active: _currentPage == 0,
                      ),
                      SizedBox(width: 5),
                      PageNavIndicator(
                        active: _currentPage == 1,
                      ),
                      SizedBox(width: 5),
                      PageNavIndicator(
                        active: _currentPage == 2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 20),
                    child: FlatButton(
                      // splashColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      onPressed: () {
                        if (_currentPage >= 2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GetStarted()),
                          );
                          return;
                        }
                        pageViewController.nextPage(
                          curve: Curves.easeIn,
                          duration: Duration(milliseconds: 250),
                        );
                      },
                      color:
                          _currentPage >= 2 ? primaryColor : Colors.transparent,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          _currentPage < 2 ? "Skip" : "Get Started",
                          style: TextStyle(
                              color: _currentPage >= 2
                                  ? secondaryColor
                                  : blackColor),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class PageNavIndicator extends StatelessWidget {
  final bool active;

  const PageNavIndicator({
    Key key,
    @required this.active,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      curve: Curves.easeIn,
      decoration: BoxDecoration(
        color: active ? primaryColor : Color(0xFFDFDFDF),
        borderRadius: new BorderRadius.circular(8.0),
        // border: new Border.all(
        //   width: 2.0,
        //   color: active ? primaryColor : Color(0xFFDFDFDF),
        // ),
      ),
      height: 5,
      width: 28,
    );
  }
}

class OnboardItem extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardItem({
    Key key,
    this.image,
    this.title,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              child: SvgPicture.asset(
                image,
                // height: 350.0,
                // width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: textStyleSmall.copyWith(
                    fontSize: 23.0,
                    fontWeight: FontWeight.w700,
                    color: primaryColor),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: blackColor,
                      fontSize: 17.0,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
      ),
    );
  }
}
