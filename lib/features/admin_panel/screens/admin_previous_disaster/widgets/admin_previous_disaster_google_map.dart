import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import '../../../../../common/widgets/appbar/appbar.dart';

import '../../../controller/admin_previous_disaster_controller.dart';
import 'package:red_zone/features/admin_panel/model/previous_disaster_model.dart';

class AdminPreviousDisasterGoogleMapScreen extends StatelessWidget {
  final controller = Get.put(AdminPreviousDisasterController());

  AdminPreviousDisasterGoogleMapScreen({
    Key? key,
    required this.isSelecting,
    this.onSaveCustomMarkerCallback,
    this.onLocationPicked,
  }) : super(key: key);

  final bool isSelecting;
  final VoidCallback? onSaveCustomMarkerCallback;
  final void Function(PlaceLocation?)? onLocationPicked;

  final Rx<PlaceLocation?> pickedLocation2 = Rx<PlaceLocation?>(null);

  bool isFirstTimeLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TAppBar(
        showBackArrow: true,
        title: Text('Previous Disaster Location', style: Theme.of(context).textTheme.headlineSmall),
        actions: [
          if (isSelecting)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () async {
                controller.onSaveCustomMarker();
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
      body: StatefulBuilder(
        builder: (context, setState) {
          return FutureBuilder<LocationData>(
              // Fetch the current location
              future: getCurrentLocation(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting && isFirstTimeLoading) {
                  isFirstTimeLoading = false;
                  return const CircularProgressIndicator();
                }
                return GoogleMap(
                  onTap: !isSelecting
                      ? null
                      : (position) async {
                          pickedLocation2.value = PlaceLocation(
                            latitude: position.latitude,
                            longitude: position.longitude,
                            address: '', // Update this based on your logic
                          );
                          setState(() {});
                          if (onLocationPicked != null) {
                            onLocationPicked!(pickedLocation2.value);
                          }
                        },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      snapshot.data!.latitude!,
                      snapshot.data!.longitude!,
                    ),
                    zoom: 16,
                  ),
                  markers: pickedLocation2.value != null && isSelecting
                      ? {
                          Marker(
                            markerId: const MarkerId('picked_location'),
                            position: LatLng(pickedLocation2.value!.latitude, pickedLocation2.value!.longitude),
                            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
                            visible: true,
                          ),
                        }
                      : {}, // Set markers to an empty set
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                );
              });
        },
      ),
    );
  }

  // Function to get the current location using the location package
  Future<LocationData> getCurrentLocation() async {
    Location location = Location();
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        throw 'Location services are disabled.';
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw 'Location permission is denied.';
      }
    }

    locationData = await location.getLocation();
    return locationData;
  }
}
