import 'package:facebook_login/login/service/local_authentication.service.dart';
import 'package:facebook_login/notification/firebase_notification.handler.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();

void setupLocator() {
  locator.registerLazySingleton(() => LocalAuthenticationService());
  locator.registerLazySingleton(() => FirebaseNotifications());
}
