import 'package:equatable/equatable.dart';
import 'package:facebook_login/login/models/user.model.dart';

enum LoadingState { none, loading, error }

abstract class LoginState extends Equatable {}

class LoginUnInitializedState extends LoginState {
  @override
  String toString() => 'LoginUnintialized';
}

class LoginLoadingState extends LoginState {
  @override
  String toString() => 'LoginLoading';
}

class LoginFacebookErrorState extends LoginState {
  String error;

  LoginFacebookErrorState([this.error]);

  @override
  String toString() => 'LoginFbError';
}

class LoginFingerPrintErrorState extends LoginState {
  String error;

  LoginFingerPrintErrorState([this.error]);

  @override
  String toString() => 'LoginFpError';
}

class LoginSuccessState extends LoginState {
  final UserModel userModel;

  LoginSuccessState(this.userModel);

  @override
  String toString() => 'LoginSucess';
}

class UserLoggedInDataAvailableState extends LoginState {
  @override
  String toString() => 'UserLoggedInDataAvailable';
}

class UserLoggedInDataUnAvailableState extends LoginState {
  @override
  String toString() => 'UserLoggedInDataUnAvailable';
}
