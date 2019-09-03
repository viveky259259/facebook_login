import 'package:facebook_login/models/user_model.dart';

abstract class LoginEvent {}

class FBLoginEvent extends LoginEvent {
  UserModel userModel;
}

class TouchIdLoginEvent extends LoginEvent {
  UserModel userModel;
}
