import 'package:facebook_login/login/blocs/login.bloc.dart';
import 'package:facebook_login/login/events/login.event.dart';
import 'package:facebook_login/login/models/user.model.dart';
import 'package:facebook_login/login/states/login.state.dart';
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
    new FirebaseNotifications().setUpFirebase();

    LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);

    _loginBloc.dispatch(LoginOfflineCheckEvent());
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      body: Center(
        child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
          print(state);
          if (state is UserLoggedInDataAvailableState)
            //ask user to login with fingerprint
            return RaisedButton(
              color: Colors.blue.shade900,
              onPressed: () {
                _loginBloc.dispatch(LoginInitEvent(LoginType.FINGERPRINT));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.fingerprint,
                      color: Colors.white70,
                      size: 32,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Continue with",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                letterSpacing: 2)),
                        TextSpan(text: "   "),
                        TextSpan(
                            text: "Fingerprint",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                letterSpacing: 2))
                      ]),
                    )
                  ],
                ),
              ),
            );
          else if (state is UserLoggedInDataUnAvailableState ||
              state is LoginUnInitializedState)
            //ask user to login with facebook
            return RaisedButton(
              color: Colors.blue.shade900,
              onPressed: () {
                _loginBloc.dispatch(LoginInitEvent(LoginType.FACEBOOK));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      "assets/icons/facebook_icon.png",
                      height: 64,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Login with",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                letterSpacing: 2)),
                        TextSpan(text: "   "),
                        TextSpan(
                            text: "Facebook",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                letterSpacing: 2))
                      ]),
                    )
                  ],
                ),
              ),
            );
          else if (state is LoginFacebookErrorState)
            //ask user to try again with facebook
            return RaisedButton(
              color: Colors.blue.shade900,
              onPressed: () {
                _loginBloc.dispatch(LoginInitEvent(LoginType.FACEBOOK));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Image.asset(
                      "assets/icons/facebook_icon.png",
                      height: 64,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Try again with",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                letterSpacing: 2)),
                        TextSpan(text: "   "),
                        TextSpan(
                            text: "Facebook",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                letterSpacing: 2))
                      ]),
                    )
                  ],
                ),
              ),
            );
          else if (state is LoginLoadingState)
            //show loading state till any update on state
            return CircularProgressIndicator();
          else if (state is LoginFingerPrintErrorState)
            //ask user to try again with fingerprint
            return RaisedButton(
              color: Colors.blue.shade900,
              onPressed: () {
                _loginBloc.dispatch(LoginInitEvent(LoginType.FINGERPRINT));
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.fingerprint,
                      color: Colors.white70,
                      size: 32,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                            text: "Try again with",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                letterSpacing: 2)),
                        TextSpan(text: "   "),
                        TextSpan(
                            text: "Fingerprint",
                            style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                letterSpacing: 2))
                      ]),
                    )
                  ],
                ),
              ),
            );
          else if (state is LoginSuccessState)
            //ask user to open maps on successful login
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                        text: "Welcome",
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            letterSpacing: 2)),
                    TextSpan(text: "   "),
                    TextSpan(
                        text: "${state.userModel.name}",
                        style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            letterSpacing: 2))
                  ]),
                ),
                SizedBox(
                  height: 16,
                ),
                RaisedButton(
                  color: Colors.blue.shade900,
                  onPressed: () {
                    _loginBloc.dispatch(StartMapEvent(context, userModel));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 20),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.map,
                          size: 32,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "Open",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    letterSpacing: 2)),
                            TextSpan(text: "   "),
                            TextSpan(
                                text: "Map",
                                style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                    letterSpacing: 2))
                          ]),
                        )
                      ],
                    ),
                  ),
                )
              ],
            );
          else
            return SizedBox();
        }),
      ),
    );
  }
}
