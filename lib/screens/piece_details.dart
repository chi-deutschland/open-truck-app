import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trucker_app/config.dart';
import 'package:trucker_app/models/piece_model.dart';
import 'package:trucker_app/screens/piece_photo_screen.dart';
import 'package:trucker_app/utils/piece_requester.dart';
import 'package:trucker_app/widgets/piece_details_card.dart';
import 'package:trucker_app/widgets/scan_button.dart';
import 'package:trucker_app/widgets/shipping_details_card.dart';
import 'package:animated_button/animated_button.dart';

class PieceDetails extends StatefulWidget {
  const PieceDetails({Key? key}) : super(key: key);

  @override
  _PieceDetailsState createState() => _PieceDetailsState();
}

class _PieceDetailsState extends State<PieceDetails> {
  void setup() async {
    var response = await PieceRequester().pieceRequest();
    PieceModel pieceData = await PieceModel.fromJson(response);

    /// this data model will be used in the real world scenario
    print('piece model' + pieceData.toString());
  }

  @override
  void initState() {
    super.initState();
    setup();
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
              largeTitle: const Text('Piece Details',
                  style: TextStyle(
                    color: blackColor,
                    fontFamily: sfprobold,
                    fontWeight: FontWeight.bold,
                    //letterSpacing: titleTextSpacing
                  )),
            )
          ];
        },
        body: Column(
          children: [
            const PieceDetailsTemporary(),
            SingleTextButtonBottomBar(
              label: 'Take Photo',
              blurStrengthX: 2,
              blurStrengthY: 10,
              height: 1,
              borderColor: grayTextColor.withOpacity(0.1),
              barColor: CupertinoDynamicColor.resolve(
                CupertinoTheme.of(context).barBackgroundColor.withOpacity(0.6),
                context,
              ),
              textStyle: const TextStyle(
                  fontSize: bigText,
                  color: blueColor,
                  fontFamily: sfproregular),
              onTap: () {
                Navigator.pushNamed(context, '/piece_photo');
              },
            )
          ],
        ),
      ),
    );
  }
}

class PieceDetailsTemporary extends StatelessWidget {
  const PieceDetailsTemporary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  PieceDetailsCard(),
                  //Divider(),
                  SizedBox(
                    height: 20,
                  ),
                  ShippingDetailsCard(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PieceDetailsList extends StatefulWidget {
  const PieceDetailsList({Key? key}) : super(key: key);

  @override
  _PieceDetailsListState createState() => _PieceDetailsListState();
}

Future getPieces() async {
  var response = await PieceRequester().pieceRequest();
  PieceModel pieceData = await PieceModel.fromJson(response);
  print('XYZ piece model' + pieceData.toString());
}

class _PieceDetailsListState extends State<PieceDetailsList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getPieces(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
