import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

// ignore: must_be_immutable
class SpinningButton extends StatefulWidget {
  SpinningButton({
    this.idleIcon,
    this.idleText,
    this.buttonState,
    this.onPress,
  });
  final String idleText;
  final IconData idleIcon;
  ButtonState buttonState;
  final Function onPress;
  @override
  _SpinningButtonState createState() => _SpinningButtonState();
}

class _SpinningButtonState extends State<SpinningButton> {
  @override
  Widget build(BuildContext context) {
    return ProgressButton.icon(
      iconedButtons: {
        ButtonState.idle: IconedButton(
            text: widget.idleText,
            icon: Icon(Icons.send, color: Colors.white),
            color: Colors.deepPurple.shade500),
        ButtonState.loading:
            IconedButton(text: "Loading", color: Colors.deepPurple.shade700),
        ButtonState.fail: IconedButton(
            text: "Failed",
            icon: Icon(Icons.cancel, color: Colors.white),
            color: Colors.red.shade300),
        ButtonState.success: IconedButton(
            text: "Success",
            icon: Icon(
              Icons.check_circle,
              color: Colors.white,
            ),
            color: Colors.green.shade400)
      },
      onPressed: widget.onPress,
      state: widget.buttonState,
    );
  }
}
