import 'package:flutter/material.dart';

// The main() function is the entry point for your app.
void main() => runApp(BullsEyeApp());

class BullsEyeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            onPressed: () {},
          )
        ],
      ),
    ));
  }
}
