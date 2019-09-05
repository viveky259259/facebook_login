import 'package:flutter/material.dart';

class NotificationUi extends StatelessWidget {
  final String title;
  final String body;

  NotificationUi(this.title, this.body);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Text(body),
        ));
  }
}
