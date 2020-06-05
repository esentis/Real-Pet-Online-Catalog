import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String _logoAnimation = 'idle';
final FlareControls _controls = FlareControls();

class AnimatedLogo extends StatefulWidget {
  AnimatedLogo({
    this.bottomLeftRadius,
    this.bottomRightRadius,
    this.topLeftRadius,
    this.topRightRadius,
    this.elevation,
    this.width,
    this.height,
    this.backGroundColor,
    this.logoColor,
  });
  final Radius topLeftRadius;
  final Radius bottomRightRadius;
  final Radius topRightRadius;
  final Radius bottomLeftRadius;
  final double elevation;
  final double width;
  final double height;
  final Color backGroundColor;
  final Color logoColor;

  @override
  _AnimatedLogoState createState() => _AnimatedLogoState();
}

class _AnimatedLogoState extends State<AnimatedLogo> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.backGroundColor,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
        topLeft: widget.topLeftRadius,
        bottomRight: widget.bottomRightRadius,
        topRight: widget.topRightRadius,
        bottomLeft: widget.bottomLeftRadius,
      )),
      elevation: widget.elevation,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  _logoAnimation = 'touch';
                });
                Future.delayed(const Duration(milliseconds: 100), () {
                  setState(() {
                    _logoAnimation = 'idle';
                  });
                });
              },
              child: Hero(
                tag: "LOGO",
                child: Container(
                  width: widget.width,
                  height: widget.height,
                  child: FlareActor(
                    'assets/logo.flr',
                    animation: _logoAnimation,
                    controller: _controls,
                    color: widget.logoColor ?? Colors.black,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
