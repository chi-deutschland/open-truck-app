import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trucker_app/config.dart';

class ShippingDetailsCard extends StatefulWidget {
  const ShippingDetailsCard({Key? key}) : super(key: key);

  @override
  _ShippingDetailsCardState createState() => _ShippingDetailsCardState();
}

class _ShippingDetailsCardState extends State<ShippingDetailsCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 2.0),
                          child: Text(
                            'Company',
                            style: TextStyle(
                                fontSize: smallText,
                                color: blackColor,
                                fontFamily: sfproregular),
                          ),
                        ),
                        Spacer(),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 25,
                          child: Image(
                            image: AssetImage('assets/apple.png'),
                          ),
                        ),
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
                    padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 2.0),
                          child: Text(
                            'Carrier',
                            style: TextStyle(
                                fontSize: smallText,
                                color: blackColor,
                                fontFamily: sfproregular),
                          ),
                        ),
                        Spacer(),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 25,
                          child: Image(
                            image: AssetImage('assets/lufthansa.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          Container(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 20, 0),
                    child: Row(
                      children: const [
                        Padding(
                          padding: EdgeInsets.only(left: 2.0),
                          child: Text(
                            'Shipper',
                            style: TextStyle(
                                fontSize: smallText,
                                color: blackColor,
                                fontFamily: sfproregular),
                          ),
                        ),
                        Spacer(),
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 25,
                          child: Image(
                            image: AssetImage('assets/db.png'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
