import 'package:flutter/material.dart';

class StyledButton extends StatelessWidget {
  // Constructor
  StyledButton({@required this.icon, this.onPressed});

  final IconData icon;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.black,
      splashColor: Colors.redAccent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      onPressed: onPressed,
      shape: CircleBorder(
        side: BorderSide(color: Colors.white),
      ),
    );
  }
}
