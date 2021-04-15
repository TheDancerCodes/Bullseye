import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:BullsEye/prompt.dart';
import 'package:BullsEye/control.dart';
import 'package:BullsEye/score.dart';
import 'package:BullsEye/gamemodel.dart';

// The main() function is the entry point for your app.
void main() => runApp(BullsEyeApp());

class BullsEyeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Set the orientation of the app tp landscape
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    // Return a material app for our BullsEye app
    return MaterialApp(
      title: 'BullsEye',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: GamePage(title: 'BullsEye'),
    );
  }
}

// GamePage is a stateful widget
class GamePage extends StatefulWidget {
  // Constructor function for GamePage
  GamePage({Key key, this.title}) : super(key: key);

  final String title;

  // GamePageState ~ The state that goes along with the GamePage stateful widget
  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  bool _alertIsInvisible = false;
  GameModel _model;

  /* To initialize the GameModel value, oveeride the init state method of
  GamePageState.

  We call the GameModel constructor, we pass in a target value of 50. 
  Later we'll set that targetValue to a random value.
  */
  @override
  void initState() {
    super.initState();
    _model = GameModel(Random().nextInt(100) + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Prompt(targetValue: _model.target),
          Control(model: _model),
          FlatButton(
            child: Text('Hit Me!', style: TextStyle(color: Colors.blue)),
            onPressed: () {
              this._alertIsInvisible = true;
              _showAlert(context);
              print("Button Pressed!");
            },
          ),
          Score(
            totalScore: _model.totalScore,
            round: _model.round,
          ),
        ],
      ),
    ));
  }

  int _pointsForCurrentRound() {
    int maximumScore = 100; // Represents the max possible score on the slider
    int sliderValue = _model.current;
    int difference = _model.target -
        sliderValue; // Tracks the difference between the target & current value of the slider

    if (difference < 0) {
      difference *= -1; // Same as difference = difference * -1;
    }

    return maximumScore - difference;
  }

  // Code to show the alert
  void _showAlert(BuildContext context) {
    // Button a user can click to dismiss the alert
    Widget okButton = FlatButton(
        child: Text("Awesome!"),
        onPressed: () {
          Navigator.of(context).pop();
          this._alertIsInvisible = false;
          print("Awesome pressed! $_alertIsInvisible");
        });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Hello there!"),
            content: Text("The slider's value is ${_model.current}.\n" +
                "You scored ${_pointsForCurrentRound()} points this round."),
            actions: <Widget>[
              okButton,
            ],
            elevation: 5,
          );
        });
  }
}
