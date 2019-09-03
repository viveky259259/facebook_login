import 'package:flutter/material.dart';

class LoginUi extends StatefulWidget {
  @override
  _LoginUiState createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          RaisedButton(
            onPressed: () {},
            child: Text("Facebook"),
          ),
          RaisedButton(
            onPressed: () {},
            child: Text("Touch id"),
          )
        ],
      ),
    );
  }
}
