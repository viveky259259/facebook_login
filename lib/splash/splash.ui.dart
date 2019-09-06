import 'package:facebook_login/login/pages/login.ui.dart';
import 'package:flutter/material.dart';

class SplashUi extends StatefulWidget {
  @override
  _SplashUiState createState() => _SplashUiState();
}

class _SplashUiState extends State<SplashUi> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      goToLogin();
    });
  }

  /*
      Open login screen after 1.5 seconds
   */
  void goToLogin() async {
    await Future.delayed(Duration(seconds: 1, milliseconds: 500));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginUi()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: Center(
        child: Text(
          "E paisa Challenge",
          style: TextStyle(fontSize: 20,color: Colors.blue.shade900),
        ),
      ),
    );
  }
}
