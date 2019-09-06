import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class MapRepository {
  LatLng currentLocation;

  Future<LatLng> fetchCurrentLocation() async {
    await checkIfLocationIsOn();
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
    currentLocation = LatLng(position.latitude, position.longitude);
    return currentLocation;
  }

  checkIfLocationIsOn() async {
    ServiceStatus serviceStatus =
        await PermissionHandler().checkServiceStatus(PermissionGroup.location);
    bool enabled = (serviceStatus == ServiceStatus.enabled);
    if (!enabled) await openLocationSetting();
    return;
  }

  Future openLocationSetting() async {
    if (Platform.isAndroid) {
      final AndroidIntent intent = new AndroidIntent(
        action: 'android.settings.LOCATION_SOURCE_SETTINGS',
      );
      return await intent.launch();
    }
  }
}
