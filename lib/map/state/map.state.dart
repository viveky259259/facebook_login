import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapState extends Equatable {}

class LocationUnInitializedState extends MapState {
  @override
  String toString() {
    return "LocationUnintitalized";
  }
}

class LocationEmptyState extends MapState {
  @override
  String toString() {
    return "LocationEmpty";
  }
}

class LocationLoadingState extends MapState {
  @override
  String toString() {
    return "LocationLoading";
  }
}

class LocationFetchedState extends MapState {
  final LatLng currentLocation;
  List<Polyline> polyLine = List();
  static LocationFetchedState instance;

  LocationFetchedState({@required this.currentLocation}) {
    instance = this;
  }

  @override
  String toString() {
    return "LocationFetched";
  }
}

class LocationErrorState extends MapState {
  @override
  String toString() {
    return "LocationError";
  }
}
