/*
 File conataining code for the slider that user will use to try and 
 hit the target.
*/

import 'package:flutter/material.dart';
import 'package:BullsEye/gamemodel.dart';

class Control extends StatefulWidget {
  // Constructor
  Control({Key key, @required this.model}) : super(key: key);

  // GameModel property
  final GameModel model;

  // To select a GamePage stateful widget, the control stateful widget needs a
  // create state override.
  @override
  _ControlState createState() => _ControlState();
}

// The state that control state is going to manage includes the value of the
// slider
class _ControlState extends State<Control> {
  double _currentValue = 50.0;

  @override
  Widget build(BuildContext context) {
    // The control needs a text label showing "1", then a slider and then another
    // text value showing "100".
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 90.0),
          child: Text(
            "1",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Slider(
            value: widget.model.current
                .toDouble(), // widget means get the model from the corresponding widget to this state object, then we grab the current value out of the model & convert it to a double.
            onChanged: (newValue) {
              setState(() {
                // Update current value of the control to new value of the slider
                _currentValue = newValue;
                widget.model.current = newValue
                    .toInt(); // Updating the current value of the model inside the widget
              });
            },
            min: 1.0,
            max: 100.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 64.0),
          child: Text(
            "100",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
