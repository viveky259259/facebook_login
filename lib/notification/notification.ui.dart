import 'package:flutter/material.dart';

class NotificationUi extends StatelessWidget {
  final Map<String, dynamic> message;

  NotificationUi(this.message);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(message["title"]),
        ),
        body: Center(
          child: Text(message["body"]),
        ));
  }
}
