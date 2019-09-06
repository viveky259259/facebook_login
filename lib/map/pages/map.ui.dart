import 'package:facebook_login/map/bloc/map.bloc.dart';
import 'package:facebook_login/map/event/map.event.dart';
import 'package:facebook_login/map/state/map.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUi extends StatefulWidget {
  @override
  _MapUiState createState() => _MapUiState();
}

class _MapUiState extends State<MapUi> {
  startLocating(MapBloc mapBloc) {
    mapBloc?.dispatch(FetchLocationEvent());
  }

  drawPolyLine(MapBloc mapBloc, LatLng targetLocation) {
    mapBloc?.dispatch(DrawRouteEvent(targetLocation));
  }

  @override
  Widget build(BuildContext context) {
    MapBloc _mapBloc = BlocProvider.of<MapBloc>(context);
    startLocating(_mapBloc);
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
      ),
      body: BlocBuilder<MapBloc, MapState>(builder: (context, state) {
        if (state is LocationUnInitializedState) {
          return RaisedButton(
            onPressed: () {},
            child: Text("Start Location"),
          );
        } else if (state is LocationEmptyState) {
          return Text("Can't Set Current Location");
        } else if (state is LocationEmptyState) {
          return Text("Something went wrong");
        } else if (state is LocationLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is LocationFetchedState) {
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: state.currentLocation,
              zoom: 14,
            ),
            onTap: (targetLocation) {
              drawPolyLine(_mapBloc, targetLocation);
            },
            markers: [
              Marker(
                  markerId: MarkerId("CurrentLocation"),
                  infoWindow: InfoWindow(title: "Your current location"),
                  position: state.currentLocation)
            ].toSet(),
            polylines: [].toSet(),
          );
        } else
          return SizedBox();
      }),
    );
  }
}
