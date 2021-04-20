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
              _showAlert(context);
              this._alertIsInvisible = true;
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

  int _sliderValue() => _model.current;

  int _pointsForCurrentRound() {
    var maximumScore = 100; // Represents the max possible score on the slider

    // Tracks the difference between the target & current value of the slider
    var difference = (_model.target - _sliderValue()).abs();

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
          setState(() {
            _model.totalScore += _pointsForCurrentRound();

            // Set a new target value on the model
            _model.target = Random().nextInt(100) + 1;
          });
        });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Hello there!"),
            content: Text("The slider's value is ${_sliderValue()}.\n" +
                "You scored ${_pointsForCurrentRound()} points this round."),
            actions: <Widget>[
              okButton,
            ],
            elevation: 5,
          );
        });
  }
}
