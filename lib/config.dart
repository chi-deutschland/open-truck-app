import 'package:flutter/cupertino.dart';
import 'package:location/location.dart';

// Colors
const Color blackColor = CupertinoColors.black;
const Color backgroundColor = CupertinoColors.secondarySystemBackground;
const Color white = CupertinoColors.white;
const Color lighterGray = Color(0xffe0e0e0);
const Color grayTextColor = Color(0xFF3C3C43);
const Color grayOpacityTextColor = Color.fromRGBO(60, 60, 67, 0.6);
const Color blueColor = Color(0xff007aff);
const Color greenColor = Color(0xff34c759);
const Color redColor = Color(0xffff3b30);
const Color iosSystemBackground = Color(0xF0F9F9F9);
const Color scanButtonColor = Color(0xFF3C3C43);

// Dimensions
const double biggerText = 30;
const double bigText = 26;
const double mediumText = 22;
const double smallText = 18;
const double smallestText = 14;

// Fonts
const String sfproregular = 'SFPro-Regular';
const String sfprobold = 'SFPro-Bold';

// Routes
class AppRoutes {
  static const home = "/";
  static const cameraStream = "/camera_stream";
  static const pouchCapture = "/pouch_capture";
  static const pouchDetails = "/pouch_details";
  static const pouchPreview = "/pouch_preview";
}

// Widgets
BoxShadow boxShadowCard = BoxShadow(
    offset: Offset.fromDirection(1.5, 5),
    blurRadius: 35,
    color: grayTextColor.withOpacity(0.23));
BorderRadius borderRadiusCard = BorderRadius.circular(12);
Radius radiusCard = const Radius.circular(12);

const topBarTextStyle = TextStyle(
  color: blueColor,
  fontFamily: sfproregular,
  fontSize: smallText,
);

const barButtonTextStyle =
    TextStyle(fontSize: bigText, color: blueColor, fontFamily: sfproregular);

//location constants
const double defaultZoom = 10.8746;
const double newZoom = 15.8746;

final LocationData defaultLocation = LocationData.fromMap(
    {'latitude': 50.1186724166, 'longitude': 8.52841809815});

const String defaultMarkerId = "1233";
