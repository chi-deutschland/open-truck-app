import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trucker_app/config.dart';
import 'package:trucker_app/widgets/overview_card.dart';
import 'package:trucker_app/widgets/tour_details_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              backgroundColor: CupertinoTheme.of(context)
                  .barBackgroundColor
                  .withOpacity(0.6),
              largeTitle: const Text('Übersicht',
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: sfprobold,
                    fontWeight: FontWeight.bold,
                  )),
            )
          ];
        },
        body: Column(
          children: const [
            MainContainer(),
          ],
        ),
      ),
    );
  }
}

class MainContainer extends StatelessWidget {
  const MainContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(fit: StackFit.loose, children: [
        Container(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: BouncingScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                OverViewCard(),
                SizedBox(
                  height: 30,
                ),
                TourDetailsCard(),
                SizedBox(
                  // Used to position all Widgets above before the BottomBar
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
