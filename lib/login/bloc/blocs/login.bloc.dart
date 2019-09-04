import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:facebook_login/login/bloc/events/login.event.dart';
import 'package:facebook_login/login/bloc/events/login.event.dart' as events;
import 'package:facebook_login/login/bloc/model/user.model.dart';
import 'package:facebook_login/login/bloc/repository/user.repository.dart';
import 'package:facebook_login/login/bloc/states/login.state.dart';
import 'package:facebook_login/login/service/local_authentication.service.dart';
import 'package:facebook_login/login/service/service_locator.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;

  LoginBloc() : userRepository = UserRepository();

  @override
  LoginState get initialState => LoginUnInitializedState();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginOfflineCheckEvent) {
      bool isUserDataAvailable = await userRepository.isUserDataAvailable();
      if (isUserDataAvailable) {
        yield UserLoggedInDataAvailableState();
      } else {
        yield UserLoggedInDataUnAvailableState();
      }
    } else if (event is LoginInitEvent) {
      if (event.loginType == LoginType.FACEBOOK) {
        yield LoginLoadingState();
        UserModel userModel = await userRepository.doFacebookLogin();
        await userRepository.saveUserInfo(userModel);
        if (userModel != null)
          yield LoginSuccessState(userModel);
        else
          yield LoginErrorState();
      } else if (event.loginType == LoginType.FINGERPRINT) {
        yield LoginLoadingState();

        final LocalAuthenticationService _localAuth =
            locator<LocalAuthenticationService>();

        bool isAuthenticated = await _localAuth.authenticate();
        if (isAuthenticated) {
          UserModel userModel = await userRepository.getLoggedInUser();
          yield LoginSuccessState(userModel);
        } else {
          yield LoginErrorState();
        }
      }
    }
  }
}
