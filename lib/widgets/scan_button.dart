import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:trucker_app/config.dart';

class SingleTextButtonBottomBar extends StatefulWidget {
  SingleTextButtonBottomBar(
      {required this.label,
      required this.onTap,
      required this.barColor,
      required this.borderColor,
      required this.textStyle,
      required this.height,
      required this.blurStrengthX,
      required this.blurStrengthY});

  final String label;
  final Color borderColor;
  final Color barColor;
  final TextStyle textStyle;
  final double height;
  final double blurStrengthX;
  final double blurStrengthY;
  final void Function() onTap;

  @override
  _SingleTextButtonBottomBarState createState() =>
      _SingleTextButtonBottomBarState();
}

class _SingleTextButtonBottomBarState extends State<SingleTextButtonBottomBar> {
  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Positioned(
      bottom: 0,
      width: screenSize.width,
      height: widget.height ?? 90,
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: widget.blurStrengthX ?? 7,
              sigmaY: widget.blurStrengthY ?? 7),
          child: Container(
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: widget.barColor,
              border: Border(
                top: BorderSide(
                    color:
                        widget.borderColor ?? scanButtonColor.withOpacity(0.1),
                    width: 0.5),
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Column(
                  // Align bottom since we want the labels to be aligned.
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(padding: EdgeInsets.only(top: 8.0)),
                    GestureDetector(
                      child: Text(widget.label, style: widget.textStyle),
                      onTap: widget.onTap,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
