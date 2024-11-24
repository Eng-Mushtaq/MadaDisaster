// google_maps_screen.dart

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../../common/widgets/appbar/appbar.dart';

class DisasterGoogleMapsScreen extends StatelessWidget {
  final double latitude;
  final double longitude;

  const DisasterGoogleMapsScreen({Key? key, required this.latitude, required this.longitude}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TAppBar(
        showBackArrow: true,
        title: Text('Disaster Location'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(latitude, longitude),
          zoom: 15,
        ),
        markers: {
          Marker(
            markerId: const MarkerId('disaster_location'),
            position: LatLng(latitude, longitude),
            infoWindow: const InfoWindow(title: 'Disaster Location'),
          ),
        },
      ),
    );
  }
}
