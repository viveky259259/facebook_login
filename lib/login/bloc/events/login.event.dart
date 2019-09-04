import 'package:equatable/equatable.dart';

enum LoginType { FACEBOOK, FINGERPRINT }

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginInitEvent extends LoginEvent {
  final LoginType loginType;

  LoginInitEvent(this.loginType);

  @override
  String toString() => 'LoginInit';
}

class LoggedInEvent extends LoginEvent {
  @override
  String toString() => 'LoggedIn';
}

class LoggedOutEvent extends LoginEvent {
  @override
  String toString() => 'LoggedOut';
}

class LoginErrorEvent extends LoginEvent {
  @override
  String toString() => 'LoginError';
}

class LoginOfflineCheckEvent extends LoginEvent {
  @override
  String toString() => 'LoginEvent';
}
