import 'dart:convert';

import 'package:facebook_login/login/database/login.db.dart';
import 'package:facebook_login/login/events/login.event.dart';
import 'package:facebook_login/login/models/user.model.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:http/http.dart' as http;

class UserRepository {
  LoginDatabase database = LoginDatabase.db;

  Future<UserModel> doFacebookLogin() async {
    // login with facebook

    var facebookLogin = FacebookLogin();
    var facebookLoginResult =
        await facebookLogin.logInWithReadPermissions(['email']);
    switch (facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.loggedIn:
        //get user data after user logged in
        var graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${facebookLoginResult.accessToken.token}');

        var profile = json.decode(graphResponse.body);
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
    //check if user data available
    UserModel userModel = await database.getLoggedInUser();
    if (userModel == null)
      return false;
    else
      return true;
  }

  Future<UserModel> getLoggedInUser() async {
    //get logged in user
    return await database.getLoggedInUser();
  }

  Future<bool> saveUserInfo(UserModel userModel) async {
    //save user data
    int result = await database.insertUser(userModel);
    if (result > -1)
      return true;
    else
      return false;
  }
}
