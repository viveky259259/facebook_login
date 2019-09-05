import 'package:bloc/bloc.dart';
import 'package:facebook_login/login/bloc/blocs/login.bloc.dart';
import 'package:facebook_login/login/service/service_locator.dart';
import 'package:facebook_login/notification/firebase_notification.handler.dart';
import 'package:facebook_login/splash/splash.ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print(error);
  }
}

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
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
    new FirebaseNotifications().setUpFirebase(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          builder: (_) => LoginBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        navigatorKey: locator<FirebaseNotifications>().navigatorKey,
        home: SplashUi(),
      ),
    );
  }
}
