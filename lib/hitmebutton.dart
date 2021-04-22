import 'package:flutter/material.dart';

class HitMeButton extends StatelessWidget {
  // Constructor
  HitMeButton({@required this.text, this.onPressed});

  final String text;
  final GestureTapCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.red[700],
      splashColor: Colors.redAccent,
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Text(
          this.text,
          maxLines: 1,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 2.0,
          ),
        ),
      ),
      onPressed: onPressed,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: Colors.white),
      ),
    );
  }
}
