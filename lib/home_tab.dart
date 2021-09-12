import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trucker_app/config.dart';
import 'package:trucker_app/screens/ladung.dart';
import 'package:trucker_app/screens/settings.dart';
import 'package:trucker_app/screens/tour.dart';
import 'screens/home.dart';

GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');

class HomeTab extends StatefulWidget {
  HomeTab({Key? key}) : super(key: key);

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  CupertinoTabController _cupertinoTabController =
      CupertinoTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      controller: _cupertinoTabController,
      tabBar: CupertinoTabBar(
          key: globalKey,
          backgroundColor: Colors.transparent,
          activeColor: blueColor,
          inactiveColor: blackColor,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.location_north), label: 'Tour'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.cube_box), label: 'Ladung'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings), label: 'Settings'),
          ]),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return HomeScreen();
          case 1:
            return TourScreen();
          case 2:
            return LadungScreen();
          case 3:
            return SettingsScreen();
          default:
            return HomeScreen();
        }
      },
    );
  }

  onTapped(int index) {
    setState(() {
      _cupertinoTabController.index = index;
    });
  }

  @override
  void dispose() {
    _cupertinoTabController.dispose();
    super.dispose();
  }
}
