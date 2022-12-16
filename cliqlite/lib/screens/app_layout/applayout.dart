import 'package:cliqlite/providers/auth_provider/auth_provider.dart';
import 'package:cliqlite/screens/account/account.dart';
import 'package:cliqlite/screens/analytics/analytics.dart';
import 'package:cliqlite/screens/home/home.dart';
import 'package:cliqlite/screens/videos/videos.dart';
import 'package:cliqlite/themes/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLayout extends StatefulWidget {
  static const String id = 'app_layout';
  final int index;
  const AppLayout({this.index});

  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  PageController _pageController = PageController();
  int _selectedIndex = 0;

  List<Widget> _screens = [
    Home(),
    Analytics(),
    Videos(),
    // LiveTutor(),
    Account(),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTapped(int selectedIndex) {
    _pageController.jumpToPage(selectedIndex);
  }

  @override
  void initState() {
    _pageController = PageController(
      initialPage: widget.index ?? 0,
    );
    _selectedIndex = widget.index ?? 0;
    AuthProvider.auth(context).setPageController(_pageController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: _onPageChanged,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTapped,
        backgroundColor: whiteColor,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 20,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/svg/home.svg",
                color: _selectedIndex == 0 ? accentColor : greyColor),
            label: 'Home',
            // title: Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 3.0),
            //   child: Text('Home',
            //       style: TextStyle(
            //           fontSize: 11.0,
            //           fontWeight: FontWeight.w600,
            //           color: _selectedIndex == 0 ? accentColor : greyColor)),
            // ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/svg/trending-up.svg",
                color: _selectedIndex == 1 ? accentColor : greyColor),
            label: 'Analytics',

            // title: Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 3.0),
            //   child: Text('Analytics',
            //       style: TextStyle(
            //           fontSize: 11.0,
            //           fontWeight: FontWeight.w600,
            //           color: _selectedIndex == 1 ? accentColor : greyColor)),
            // ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset("assets/images/svg/video.svg",
                height: 20.0,
                color: _selectedIndex == 2 ? accentColor : greyColor),
            label: 'Videos',
            // title: Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 3.0),
            //   child: Text('Videos',
            //       style: TextStyle(
            //           fontSize: 11.0,
            //           fontWeight: FontWeight.w600,
            //           color: _selectedIndex == 2 ? accentColor : greyColor)),
            // ),
          ),
          // BottomNavigationBarItem(
          //   icon: SvgPicture.asset("assets/images/svg/play.svg",
          //       height: 20.0,
          //       color: _selectedIndex == 3 ? accentColor : greyColor),
          //   title: Padding(
          //     padding: const EdgeInsets.symmetric(vertical: 3.0),
          //     child: Text('Live Tutor',
          //         style: TextStyle(
          //             fontSize: 11.0,
          //             fontWeight: FontWeight.w600,
          //             color: _selectedIndex == 3 ? accentColor : greyColor)),
          //   ),
          // ),
          BottomNavigationBarItem(
              icon: SvgPicture.asset("assets/images/svg/user.svg",
                  height: 20.0,
                  color: _selectedIndex == 3 ? accentColor : greyColor),
              label: 'Account'
              // title: Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 3.0),
              //   child: Text('Account',
              //       style: TextStyle(
              //           fontSize: 11.0,
              //           fontWeight: FontWeight.w600,
              //           color: _selectedIndex == 3 ? accentColor : greyColor)),
              // ),
              ),
        ],
      ),
    );
  }
}
