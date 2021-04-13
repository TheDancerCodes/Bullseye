/*
 This file contains code that puts the text at the top of the screen ans then 
 shows the target value that the user is trying to hit in the game.
*/
import 'package:flutter/material.dart';

class Prompt extends StatelessWidget {
  // Constructor function for a Prompt object
  Prompt({@required this.targetValue});

  final int targetValue;

  @override
  Widget build(BuildContext context) {
    // Return a column widget that has 2 child text widgets
    return Column(
      children: <Widget>[
        Text("PUT THE BULLSEYE AS CLOSE AS YOU CAN TO"),
        Text("$targetValue"),
      ],
    );
  }
}
