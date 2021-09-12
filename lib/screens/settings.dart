import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trucker_app/config.dart';
import 'package:awesome_card/awesome_card.dart';
import 'package:trucker_app/models/transport_means_model.dart';

Driver driver = const Driver(
    licenseNo: '1234',
    imagePath: 'https://xyz.com',
    lastName: 'Meschkov',
    firstName: 'Oliver',
    licenseExpiry: '12/21',
    checksum: 'd41d8cd98f00b204e980');

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  String cardNumber = driver.licenseNo;
  String cardHolderName = driver.firstName + ' ' + driver.lastName;
  String expiryDate = driver.licenseExpiry;
  String cvv = '';
  bool showBack = false;

  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _focusNode.hasFocus ? showBack = true : showBack = false;
      });
    });
  }

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
              largeTitle: const Text('Settings',
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: sfprobold,
                    fontWeight: FontWeight.bold,
                  )),
            )
          ];
        },
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            Center(
              child: ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: Ink.image(
                    image: const AssetImage('assets/driver.jpeg'),
                    fit: BoxFit.cover,
                    width: 128,
                    height: 128,
                    // child: InkWell(onTap: onClicked),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            CreditCard(
              cardNumber: cardNumber,
              frontTextColor: blackColor,
              cardExpiry: expiryDate,
              cardHolderName: cardHolderName,
              cvv: cvv,
              bankName: 'Drivers License',
              showBackSide: showBack,
              frontBackground: CardBackgrounds.white,
              backBackground: CardBackgrounds.white,
              showShadow: true,
            ),
            const SizedBox(
              height: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: CupertinoTextField(
                    placeholder: 'License Number',
                    //decoration: InputDecoration(hintText: 'Card Number'),
                    maxLength: 19,
                    onChanged: (value) {
                      setState(() {
                        cardNumber = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: CupertinoTextField(
                    //decoration: InputDecoration(hintText: 'Card Expiry'),
                    placeholder: 'License Expiry',
                    maxLength: 5,
                    onChanged: (value) {
                      setState(() {
                        expiryDate = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: CupertinoTextField(
                    //decoration: InputDecoration(hintText: 'Card Holder Name'),
                    placeholder: 'License holder name',
                    onChanged: (value) {
                      setState(() {
                        cardHolderName = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: CupertinoTextField(
                    // decoration: InputDecoration(hintText: 'CVV'),
                    placeholder: 'CVV',
                    maxLength: 3,
                    onChanged: (value) {
                      setState(() {
                        cvv = value;
                      });
                    },
                    focusNode: _focusNode,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
