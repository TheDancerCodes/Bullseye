/*
 File conataining code for the slider that user will use to try and 
 hit the target.
*/

import 'package:flutter/material.dart';
import 'package:BullsEye/gamemodel.dart';
import 'package:BullsEye/sliderthumbimage.dart';
import 'dart:ui' as ui;
import 'dart:typed_data';
import 'package:flutter/services.dart';

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
  ui.Image _sliderImage;

  // To use the _sliderImage, we need a helper fucntion.
  // The load() function is loadong the asset from the package bundle, and its
  // doing it in an asycnhronous fashion ~ doesn't block the main code that's
  // running in the app(UI).
  Future<ui.Image> _load(String asset) async {
    ByteData data = await rootBundle.load(asset);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List());
    ui.FrameInfo fi = await codec.getNextFrame();
    return fi.image;
  }

  @override
  void initState() {
    _load("images/nub.png").then((image) {
      setState(() {
        _sliderImage = image;
      });
    });
    super.initState();
  }

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
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Colors.red[700],
              inactiveTrackColor: Colors.red[700],
              trackShape: RoundedRectSliderTrackShape(),
              trackHeight: 8.0,
              thumbColor: Colors.redAccent,
              thumbShape: SliderThumbImage(_sliderImage),
              overlayColor: Colors.red.withAlpha(32),
              overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
            ),
            child: Slider(
              value: widget.model.current
                  .toDouble(), // widget means get the model from the corresponding widget to this state object, then we grab the current value out of the model & convert it to a double.
              onChanged: (newValue) {
                setState(() {
                  widget.model.current = newValue
                      .toInt(); // Updating the current value of the model inside the widget
                });
              },
              min: 1.0,
              max: 100.0,
            ),
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
