import 'dart:io';

import 'package:android_intent/android_intent.dart';
import 'package:bloc/bloc.dart';
import 'package:facebook_login/map/events/map.event.dart';
import 'package:facebook_login/map/repository/map.repository.dart';
import 'package:facebook_login/map/states/map.state.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final MapRepository mapRepository;

  MapBloc() : mapRepository = MapRepository();

  @override
  MapState get initialState => LocationUnInitializedState();

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    if (event is FetchLocationEvent) {
      LatLng currentLocation = await mapRepository.fetchCurrentLocation();
      yield LocationFetchedState(currentLocation: currentLocation);
    } else if (event is DrawRouteEvent) {
      LocationFetchedState locationFetchedState = LocationFetchedState.instance;
      locationFetchedState.polyLine.add(Polyline(
          polylineId:
              PolylineId(locationFetchedState.polyLine.length.toString()),
          points: [event.targetLatLng, locationFetchedState.currentLocation],
          width: 4,
          color: Colors.indigo.shade900,
          zIndex: 3,
          endCap: Cap.roundCap,
          startCap: Cap.roundCap,
          patterns: [
            PatternItem.dot,
            PatternItem.dash(2),
            PatternItem.gap(4)
          ]));
      locationFetchedState.markers.addAll([
        Marker(
            markerId: MarkerId(event.targetLatLng.hashCode.toString()),
            position: event.targetLatLng,
            onTap: () {
              dispatch(OpenRoute(
                  locationFetchedState.currentLocation, event.targetLatLng));
            })
      ]);

//      locationFetchedState.addMarker(locationFetchedState.currentLocation);
      yield LocationLoadingState();
      yield LocationFetchedState.getClone(locationFetchedState);
    } else if (event is OpenRoute) {
      showRoute(event.originLatLng, event.destinationLatLng);
    }
  }

  showRoute(LatLng originLatLng, LatLng destinationLatLng) async {
    String origin =
        "${originLatLng.latitude},${originLatLng.longitude}"; // lat,long like 123.34,68.56
    String destination =
        "${destinationLatLng.latitude},${destinationLatLng.longitude}";
    if (Platform.isAndroid) {
      final AndroidIntent intent = new AndroidIntent(
          action: 'action_view',
          data: Uri.encodeFull(
              "https://www.google.com/maps/dir/?api=1&origin=" +
                  origin +
                  "&destination=" +
                  destination +
                  "&travelmode=driving&dir_action=navigate"),
          package: 'com.google.android.apps.maps');
      intent.launch();
    } else {
      String url = "https://www.google.com/maps/dir/?api=1&origin=" +
          origin +
          "&destination=" +
          destination +
          "&travelmode=driving&dir_action=navigate";
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}
