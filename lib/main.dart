import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:BullsEye/prompt.dart';
import 'package:BullsEye/control.dart';
import 'package:BullsEye/score.dart';
import 'package:BullsEye/gamemodel.dart';
import 'package:BullsEye/hitmebutton.dart';
import 'package:BullsEye/textstyles.dart';
import 'package:BullsEye/styledbutton.dart';

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

    // Remove Android Status bar
    SystemChrome.setEnabledSystemUIOverlays([]);

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
    _model = GameModel(_newTargetValue());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 48.0, bottom: 32.0),
                  child: Prompt(targetValue: _model.target),
                ),
                Control(model: _model),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: HitMeButton(
                    text: 'HIT ME!',
                    onPressed: () {
                      _showAlert(context);
                      this._alertIsInvisible = true;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Score(
                    totalScore: _model.totalScore,
                    round: _model.round,
                    onStartOver: _startNewGame,
                  ),
                ),
              ],
            ),
          )),
    );
  }

  int _sliderValue() => _model.current;

  int _pointsForCurrentRound() {
    var maximumScore = 100; // Represents the max possible score on the slider

    // Tracks the difference between the target & current value of the slider
    var difference = _amountOff();

    var bonus = 0;

    if (difference == 0) {
      bonus = 100;
    } else if (difference == 1) {
      bonus = 50;
    }

    return maximumScore - difference + bonus;
  }

  int _newTargetValue() => Random().nextInt(100) + 1;

  void _startNewGame() {
    // Update the model state to reflect that we are starting a new game
    setState(() {
      _model.totalScore = GameModel.SCORE_START;
      _model.round = GameModel.ROUND_START;
      _model.target = _newTargetValue();
      _model.current = GameModel.SLIDER_START;
    });
  }

  // Code to show the alert
  void _showAlert(BuildContext context) {
    // Button a user can click to dismiss the alert
    Widget okButton = StyledButton(
        icon: Icons.close,
        onPressed: () {
          Navigator.of(context).pop();
          this._alertIsInvisible = false;
          setState(() {
            _model.totalScore += _pointsForCurrentRound();

            // Set a new target value on the model
            _model.target = _newTargetValue();

            // Increment the round in the model
            _model.round += 1;
          });
        });
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              _alertTitle(),
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize
                  .min, // Compress the column to be the minimum it can be
              children: <Widget>[
                Text(
                  "THE SLIDER'S VALUE IS",
                  textAlign: TextAlign.center,
                ),
                Text(
                  "${_sliderValue()}",
                  style: TargetTextStyle.bodyText1(context),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "\nYou scored ${_pointsForCurrentRound()} points this round.",
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            actions: <Widget>[
              okButton,
            ],
            elevation: 5,
          );
        });
  }

  // Calculation for the difference of the targetValue & sliderVlaue
  int _amountOff() => (_model.target - _sliderValue()).abs();

  String _alertTitle() {
    var difference = _amountOff();

    String title;

    if (difference == 0) {
      title = "Perfect!";
    } else if (difference < 5) {
      title = "You almost had it!";
    } else if (difference <= 10) {
      title = "Not bad.";
    } else {
      title = "Are you even trying?";
    }

    return title;
  }
}
