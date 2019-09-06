import 'dart:convert';

import 'package:facebook_login/login/database/login.db.dart';
import 'package:facebook_login/login/events/login.event.dart';
import 'package:facebook_login/login/models/user.model.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  LoginDatabase database = LoginDatabase.db;

  Future<UserModel> doLogin(LoginType type) async {
    if (type == LoginType.FACEBOOK) {
      UserModel userModel = await doFacebookLogin();
    } else if (type == LoginType.FINGERPRINT) {
      return null;
    } else {
      return null;
    }
    return null;
  }

  Future<UserModel> doFacebookLogin() async {
    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
        await facebookLogin.logInWithReadPermissions(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        print("Error");
//        onLoginStatusChanged(false, null);
        break;
      case FacebookLoginStatus.cancelledByUser:
        print("CancelledByUser");
        break;
      case FacebookLoginStatus.loggedIn:
        print("LoggedIn");

        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${facebookLoginResult.accessToken.token}');

        var profile = json.decode(graphResponse.body);
        print(profile.toString());
        UserModel userModel =
            UserModel(name: profile["name"], email: profile["email"]);
        return userModel;
        break;
      default:
        return null;
    }
    return null;
  }

  Future<bool> isUserDataAvailable() async {
    UserModel userModel = await database.getLoggedInUser();
    if (userModel == null)
      return false;
    else
      return true;
  }

  Future<UserModel> getLoggedInUser() async {
    return await database.getLoggedInUser();
  }

  Future<bool> saveUserInfo(UserModel userModel) async {
    int result = await database.insertUser(userModel);
    if (result > -1)
      return true;
    else
      return false;
  }
}
