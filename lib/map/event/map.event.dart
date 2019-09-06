import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapEvent extends Equatable {
  MapEvent([List props = const []]) : super(props);
}

class FetchLocationEvent extends MapEvent {
  @override
  String toString() => 'FetchLocation';
}

class DrawRouteEvent extends MapEvent {
  final LatLng targetLatLng;

  DrawRouteEvent(this.targetLatLng);

  @override
  String toString() => 'DrawRoute';
}
