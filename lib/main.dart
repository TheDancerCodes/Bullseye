import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Hello BullsEye 🎯🎯",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
          ),
          FlatButton(
            child: Text('Hit Me!', style: TextStyle(color: Colors.blue)),
            onPressed: () {
              this._alertIsInvisible = true;
              _showAlert(context);
              print("Button Pressed!");
            },
          ),
        ],
      ),
    ));
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
            content: Text("This is my first pop-up"),
            actions: <Widget>[
              okButton,
            ],
            elevation: 5,
          );
        });
  }
}
