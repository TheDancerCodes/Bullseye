/*
 File conataining code for the slider that user will use to try and 
 hit the target.
*/

import 'package:flutter/material.dart';

class Control extends StatefulWidget {
  // Constructor
  Control({Key key}) : super(key: key);

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
          padding: const EdgeInsets.all(32.0),
          child: Text("1"),
        ),
        Expanded(
          child: Slider(
            value: _currentValue,
            onChanged: (newValue) {
              setState(() {
                // Update current value of the control to new value of the slider
                _currentValue = newValue;
                print(_currentValue);
              });
            },
            min: 1.0,
            max: 100.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(32.0),
          child: Text("100"),
        ),
      ],
    );
  }
}
