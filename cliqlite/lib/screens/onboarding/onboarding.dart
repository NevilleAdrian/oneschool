import 'package:cliqlite/models/auth_model/first_time/first_time.dart';
import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/repository/hive_repository.dart';
import 'package:cliqlite/screens/background/background.dart';
import 'package:cliqlite/screens/get_started/get_started.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:cliqlite/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingScreen extends StatefulWidget {
  static String id = 'onboarding';

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final pageViewController = PageController();
  int _currentPage = 0;
  FirstTime first;
  HiveRepository _hiveRepository = HiveRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return OnBoardingBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: _currentPage >= 2
            ? CrossAxisAlignment.stretch
            : CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: 500,
            child: PageView(
              controller: pageViewController,
              onPageChanged: (page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: <Widget>[
                OnboardItem(
                  image: "assets/images/svg/Learn_From_Home_1_.svg",
                  title:
                      "Access a Video Library of Your Favorite School Subjects",
                  description:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tortor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tortor.",
                ),
                OnboardItem(
                  image: "assets/images/svg/Online_Courses_1_.svg",
                  title: "Learn From The Best Lesson Tutors ",
                  description:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tortor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tortor.",
                ),
                OnboardItem(
                  image: "assets/images/svg/Student_Desk_1_.svg",
                  title: "Test Yourself With The In-App Quiz",
                  description:
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tortor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tortor.",
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
            child: GestureDetector(
              onTap: () {
                if (_currentPage >= 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GetStarted()),
                  );
                  first = AuthProvider.auth(context)
                      .myFirst(FirstTime.fromJson({"bool": true}));
                  _hiveRepository.add<FirstTime>(
                      name: kFirst, key: 'first', item: first);
                  return;
                }
                pageViewController.nextPage(
                  curve: Curves.easeIn,
                  duration: Duration(milliseconds: 250),
                );
              },
              child: Container(
                // splashColor: Colors.transparent,
                decoration: BoxDecoration(
                  color: _currentPage >= 2 ? primaryColor : secondaryColor,
                  borderRadius: BorderRadius.circular(15),
                  gradient: _currentPage >= 2
                      ? const LinearGradient(
                          colors: [
                            Color(0XFF07AB2C),
                            Color(0XFF69E905),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                      : null,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  child: Text(
                    _currentPage < 2 ? "Skip" : "Get Started",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color:
                            _currentPage >= 2 ? secondaryColor : accentColor),
                  ),
                ),
              ),
            ),
          )
        ],
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
        color: active ? accentColor : Color(0xFFDFDFDF),
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              image,
              width: 235,
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: textStyleSmall.copyWith(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      color: primaryColor),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: greyishColor,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
