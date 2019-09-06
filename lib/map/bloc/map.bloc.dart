import 'package:bloc/bloc.dart';
import 'package:facebook_login/map/event/map.event.dart';
import 'package:facebook_login/map/repository/map.repository.dart';
import 'package:facebook_login/map/state/map.state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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
    }
    if (event is DrawRouteEvent) {
      LocationFetchedState locationFetchedState = LocationFetchedState.instance;
//      locationFetchedState.polyLine.add(Polyline
//                                          (polylineId:locationFetchedState
//                                            .polyLine.length.toString() ));
    }
  }
}
