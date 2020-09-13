import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_controls.dart';
import 'package:flutter/material.dart';

class DrawerIcon extends StatelessWidget {
  const DrawerIcon({
    @required this.color,
    @required this.flareController,
    @required this.animationName,
    Key key,
  }) : super(key: key);
  final Color color;
  final FlareControls flareController;
  final String animationName;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: const Border.fromBorderSide(
          BorderSide(
            color: Colors.white,
            width: 3,
          ),
        ),
      ),
      width: 50,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FlareActor(
          'assets/settings_icon.flr',
          animation: animationName,
          controller: flareController,
          color: Colors.white,
          fit: BoxFit.fitWidth,
        ),
      ),
    );
  }
}
