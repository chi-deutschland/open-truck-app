import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trucker_app/config.dart';
import 'package:trucker_app/providers/tour_details_provider.dart';
import 'package:provider/provider.dart';

class OverViewCard extends StatefulWidget {
  const OverViewCard({Key? key}) : super(key: key);

  @override
  _OverViewCardState createState() => _OverViewCardState();
}

class _OverViewCardState extends State<OverViewCard> {
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 20, left: 20, top: 5),
      decoration: BoxDecoration(
        borderRadius: borderRadiusCard,
        boxShadow: [
          boxShadowCard,
        ],
        color: white,
      ),
      child: Column(
        children: [
          Container(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/pic.png'),
                    alignment: Alignment(1.0, 1.0)),
                borderRadius: BorderRadius.only(
                    topLeft: radiusCard, topRight: radiusCard),
                color: CupertinoColors.systemYellow,
              ),
            ),
          ),
          Container(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                      child: Row(
                        children: [
                          _connectionStatus == 'Online'
                              ? Icon(CupertinoIcons.wifi, color: greenColor)
                              : Icon(CupertinoIcons.wifi_slash,
                                  color: redColor),
                          Padding(
                            padding: const EdgeInsets.only(left: 3.0),
                            child: Text('Status',
                                style: TextStyle(
                                    fontSize: smallText,
                                    color: _connectionStatus == 'Online'
                                        ? greenColor
                                        : redColor,
                                    fontFamily: sfproregular)),
                          ),
                        ],
                      )),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(10, 35, 20, 10),
                    child: Text('$_connectionStatus',
                        style: TextStyle(
                            fontSize: smallText,
                            color: grayOpacityTextColor,
                            fontFamily: sfproregular))),
              ],
            ),
          ),
          Divider(),
          Container(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
                    child: Row(
                      children: const [
                        Icon(
                          CupertinoIcons.bus,
                          color: blackColor,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.0),
                          child: Text(
                            'Fahrzeug',
                            style: TextStyle(
                                fontSize: smallText,
                                color: blackColor,
                                fontFamily: sfproregular),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'F-CH-2022',
                          style: TextStyle(
                              fontSize: smallText,
                              color: blackColor,
                              fontFamily: sfproregular),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 20, 20),
                    child: Row(
                      children: const [
                        Icon(
                          CupertinoIcons.timer_fill,
                          color: blackColor,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.0),
                          child: Text('Distanz',
                              style: TextStyle(
                                  fontSize: smallText,
                                  color: blackColor,
                                  fontFamily: sfproregular)),
                        ),
                        Spacer(),
                        Text(
                          '117,5 km',
                          style: TextStyle(
                              fontSize: smallText,
                              color: blackColor,
                              fontFamily: sfproregular),
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 35, 20, 0),
                  child: Text(
                    'Heute',
                    style: TextStyle(
                        fontSize: smallText,
                        color: grayOpacityTextColor,
                        fontFamily: sfproregular),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 20, 20),
                    child: Row(
                      children: const [
                        Icon(
                          CupertinoIcons.timer_fill,
                          color: blackColor,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.0),
                          child: Text('Distanz',
                              style: TextStyle(
                                  fontSize: smallText,
                                  color: blackColor,
                                  fontFamily: sfproregular)),
                        ),
                        Spacer(),
                        Text(
                          '22.523,8 km',
                          style: TextStyle(
                              fontSize: smallText,
                              color: blackColor,
                              fontFamily: sfproregular),
                        )
                      ],
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 35, 20, 10),
                  child: Text(
                    'Ingesamt',
                    style: TextStyle(
                        fontSize: smallText,
                        color: grayOpacityTextColor,
                        fontFamily: sfproregular),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        setState(() => _connectionStatus = 'Online');
        break;

      case ConnectivityResult.none:
        setState(() => _connectionStatus = 'Offline');
        break;
      default:
        setState(() => _connectionStatus = 'Failed to get connectivity.');
        break;
    }
  }
}
