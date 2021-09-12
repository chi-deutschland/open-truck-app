import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:trucker_app/config.dart';
import 'package:animated_button/animated_button.dart';
import 'package:trucker_app/providers/tour_details_provider.dart';
import 'package:provider/provider.dart';

class PicturePreviewScreen extends StatefulWidget {
  final String imagePath;

  const PicturePreviewScreen({Key? key, required this.imagePath})
      : super(key: key);

  @override
  _PicturePreviewScreenState createState() => _PicturePreviewScreenState();
}

class _PicturePreviewScreenState extends State<PicturePreviewScreen> {
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
                largeTitle: const Text('Picture Preview',
                    style: TextStyle(
                      color: blackColor,
                      fontFamily: sfprobold,
                      fontWeight: FontWeight.bold,
                      //letterSpacing: titleTextSpacing
                    )),
              )
            ];
          },
          body: Stack(
            children: [
              Image.file(File(widget.imagePath)),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedButton(
                  color: greenColor,
                  child: const Text(
                    'Upload',
                    style: TextStyle(
                      fontSize: 22,
                      color: white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              )
            ],
          )),
    );
  }
}
