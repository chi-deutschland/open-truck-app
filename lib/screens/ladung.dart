import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:trucker_app/config.dart';
import 'package:animated_button/animated_button.dart';
import 'package:trucker_app/providers/tour_details_provider.dart';
import 'package:trucker_app/screens/camera_stream.dart';
import 'package:provider/provider.dart';

class LadungScreen extends StatefulWidget {
  const LadungScreen({Key? key}) : super(key: key);

  @override
  _LadungScreenState createState() => _LadungScreenState();
}

class _LadungScreenState extends State<LadungScreen> {
  @override
  Widget build(BuildContext context) {
    var loadStatus = Provider.of<TourDetailsProvider>(context).getLoadStatus();
    return CupertinoPageScaffold(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            CupertinoSliverNavigationBar(
              backgroundColor: CupertinoTheme.of(context)
                  .barBackgroundColor
                  .withOpacity(0.6),
              largeTitle: const Text('Ladung',
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: sfprobold,
                    fontWeight: FontWeight.bold,
                  )),
            )
          ];
        },
        body: Center(
          child: AnimatedButton(
            color: loadStatus ? greenColor : redColor,
            child: Text(
              loadStatus ? 'Load' : 'Unload',
              style: const TextStyle(
                fontSize: 22,
                color: white,
                fontWeight: FontWeight.w500,
              ),
            ),
            onPressed: () {
              if (loadStatus == true) {
                Navigator.of(context).push(CupertinoPageRoute(
                    builder: (BuildContext routeContext) =>
                        CameraStream(key: ValueKey(Random().nextInt(255)))));
                Provider.of<TourDetailsProvider>(context, listen: false)
                    .makeCaptureButtonRed();
              } else {
                Provider.of<TourDetailsProvider>(context, listen: false)
                    .makeCaptureButtonGreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
