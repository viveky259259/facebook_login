import 'package:facebook_login/login/bloc/blocs/login.bloc.dart';
import 'package:facebook_login/login/bloc/events/login.event.dart';
import 'package:facebook_login/login/bloc/model/user.model.dart';
import 'package:facebook_login/login/bloc/states/login.state.dart';
import 'package:facebook_login/notification/firebase_notification.handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginUi extends StatefulWidget {
  @override
  _LoginUiState createState() => _LoginUiState();
}

class _LoginUiState extends State<LoginUi> {
  UserModel userModel;

  @override
  Widget build(BuildContext context) {
    new FirebaseNotifications().setUpFirebase(context);

    LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);

    _loginBloc.dispatch(LoginOfflineCheckEvent());
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
        if (state is UserLoggedInDataAvailableState)
          return RaisedButton(
            onPressed: () {
              _loginBloc.dispatch(LoginInitEvent(LoginType.FINGERPRINT));
            },
            child: Text("Touch id"),
          );
        else if (state is UserLoggedInDataUnAvailableState ||
            state is LoginUnInitializedState)
          return RaisedButton(
            onPressed: () {
              _loginBloc.dispatch(LoginInitEvent(LoginType.FACEBOOK));
            },
            child: Text("Facebook"),
          );
        else if (state is LoginLoadingState)
          return CircularProgressIndicator();
        else if (state is LoginSuccessState) {
          userModel = state.userModel;
          return Text("User:${userModel.name}");
        } else
          return SizedBox();
      }),
    );
  }
}
