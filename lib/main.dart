import 'package:bloc/bloc.dart';
import 'package:facebook_login/login/blocs/login.bloc.dart';
import 'package:facebook_login/login/service/service_locator.dart';
import 'package:facebook_login/map/blocs/map.bloc.dart';
import 'package:facebook_login/notification/firebase_notification.handler.dart';
import 'package:facebook_login/splash/splash.ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //bloc for login module
        BlocProvider<LoginBloc>(
          builder: (_) => LoginBloc(),
        ),
        //bloc for map module
        BlocProvider<MapBloc>(
          builder: (_) => MapBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'E-paisa Challenge',
        theme: ThemeData(
          // change primary color of app
          primarySwatch: Colors.indigo,
        ),
        home: SplashUi(),
      ),
    );
  }
}
