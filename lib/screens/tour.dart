import 'package:flutter/cupertino.dart';
import 'package:trucker_app/config.dart';

class TourScreen extends StatefulWidget {
  const TourScreen({Key? key}) : super(key: key);

  @override
  _TourScreenState createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen> {
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
              largeTitle: const Text('Tour',
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: sfprobold,
                    fontWeight: FontWeight.bold,
                  )),
            )
          ];
        },
        body: Column(
          children: [
            Container(),
          ],
        ),
      ),
    );
  }
}
