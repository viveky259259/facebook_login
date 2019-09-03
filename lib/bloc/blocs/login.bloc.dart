import 'package:bloc/bloc.dart';
import 'package:facebook_login/bloc/events/login.event.dart';

class LoginBloc extends Bloc<LoginEvent, dynamic> {
  @override
  get initialState => null;

  @override
  Stream<dynamic> mapEventToState(LoginEvent event) async* {
    if (event is FBLoginEvent) {
      yield currentState;
    } else if (event is TouchIdLoginEvent) {
      yield currentState;
    }
  }
}
