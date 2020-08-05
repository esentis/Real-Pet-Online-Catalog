import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

String _logoAnimation = 'idle';
final FlareControls _controls = FlareControls();

class RealPetLogo extends StatefulWidget {
  const RealPetLogo({
    this.blurRadius,
    this.containerHeight,
    this.containerWidth,
    this.bottomLeftRadius,
    this.topRightRadius,
    this.bottomRightRadius,
    this.topLeftRadius,
  });
  final double blurRadius;
  final double containerWidth;
  final double containerHeight;
  final Radius topLeftRadius;
  final Radius topRightRadius;
  final Radius bottomLeftRadius;
  final Radius bottomRightRadius;

  @override
  _RealPetLogoState createState() => _RealPetLogoState();
}

class _RealPetLogoState extends State<RealPetLogo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.containerWidth,
      height: widget.containerHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: widget.topLeftRadius,
          topRight: widget.topRightRadius,
          bottomRight: widget.bottomRightRadius,
          bottomLeft: widget.bottomLeftRadius,
        ),
        boxShadow: [
          BoxShadow(color: Colors.white, blurRadius: widget.blurRadius),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
        child: Hero(
          tag: 'LOGO',
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: FlareActor(
              'assets/logo.flr',
              animation: _logoAnimation,
              controller: _controls,
              color: kResultsLogoColor,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ),
    );
  }
}
