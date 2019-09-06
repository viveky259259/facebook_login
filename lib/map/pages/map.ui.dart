import 'package:facebook_login/login/models/user.model.dart';
import 'package:facebook_login/map/blocs/map.bloc.dart';
import 'package:facebook_login/map/events/map.event.dart';
import 'package:facebook_login/map/states/map.state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapUi extends StatefulWidget {
  final UserModel userModel;

  MapUi(this.userModel);

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
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        title: Text("Map"),
      ),
      body: Center(
        child: BlocBuilder<MapBloc, MapState>(builder: (context, state) {
          if (state is LocationUnInitializedState) {
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircularProgressIndicator(),
                SizedBox(
                  width: 16,
                ),
                Text("Getting your location...",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.blue.shade900,
                        letterSpacing: 2)),
              ],
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
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Tap anywhere on screen to draw line",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.blue.shade900,
                          letterSpacing: 1.5)),
                ),
                Expanded(
                  child: GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    rotateGesturesEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: state.currentLocation,
                      zoom: 14,
                    ),
                    onTap: (targetLocation) {
                      drawPolyLine(_mapBloc, targetLocation);
                    },
                    markers: state.markers.toSet(),
                    polylines: state.polyLine.toSet(),
                  ),
                ),
              ],
            );
          } else
            return SizedBox();
        }),
      ),
    );
  }
}
