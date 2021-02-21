import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  Set<Marker> googleMapMarker = HashSet<Marker>();
  GoogleMapController mapController;
  BitmapDescriptor grandpaIcon;
  Set<Circle> warningcircle = HashSet<Circle>();
  void addGrandpaIcon() async {
    grandpaIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(), "assets/old_6.png");
  }

  void addRadius() {
    warningcircle.add(
      Circle(
          circleId: CircleId("0"),
          center: LatLng(49.933611, -119.401389),
          radius: 1000,
          strokeWidth: 2,
          fillColor: Color.fromRGBO(102, 51, 153, .5)),
    );
  }

  void _getCurrentLocation() async {
    Position myposition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(myposition);
  }

  void addMap() async {
    String style = await DefaultAssetBundle.of(context)
        .loadString('assets/map_style.json');
    mapController.setMapStyle(style);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addGrandpaIcon();

    addRadius();
    _getCurrentLocation();
  }

  void mapCreated(GoogleMapController controller) {
    mapController = controller;
    setState(() {
      googleMapMarker.add(
        Marker(
            markerId: MarkerId("0"),
            position: LatLng(49.933611, -119.401389),
            infoWindow: InfoWindow(
                title: "Grandpa is here", snippet: "Within safety radius"),
            icon: grandpaIcon),
      );
    });
    addMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      onMapCreated: mapCreated,
      initialCameraPosition:
          CameraPosition(target: LatLng(49.933611, -119.401389), zoom: 15),
      markers: googleMapMarker,
      circles: warningcircle,
      myLocationEnabled: true,
      myLocationButtonEnabled: true,
    ));
  }
}
