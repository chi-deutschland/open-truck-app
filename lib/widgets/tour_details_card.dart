import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trucker_app/config.dart';
import 'package:trucker_app/utils/icon_utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:trucker_app/utils/location_updater.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class TourDetailsCard extends StatefulWidget {
  const TourDetailsCard({Key? key}) : super(key: key);

  @override
  _TourDetailsCardState createState() => _TourDetailsCardState();
}

class _TourDetailsCardState extends State<TourDetailsCard> {
  String googleAPIKey = 'YOUR-API-KEY-HERE';
  BitmapDescriptor cabIcon = BitmapDescriptor.defaultMarker;
  LocationData currentLocation = defaultLocation;
  Set<Polyline> _polylines = Set<Polyline>();
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;
  // a reference to the destination location
  LocationData destinationLocation =
      LocationData.fromMap({"latitude": 50.042148, "longitude": 8.5535690});
  late GoogleMapController _controller;
  var location = Location();
  // for my custom marker pins
  late BitmapDescriptor sourceIcon;
  late BitmapDescriptor destinationIcon;

  void setup() {
    _subscribeToLocation();
    polylinePoints = PolylinePoints();
    // set custom marker pins
    setSourceAndDestinationIcons();
  }

  void setSourceAndDestinationIcons() async {
    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.0),
            'assets/destination_map_marker.png')
        .then((onValue) {
      sourceIcon = onValue;
    });

    BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.0),
            'assets/destination_map_marker.png')
        .then((onValue) {
      destinationIcon = onValue;
    });
  }

  void _subscribeToLocation() {
    location.onLocationChanged.listen((LocationData newLocation) {
      gotNewLocation(newLocation);
    });
  }

  void gotNewLocation(LocationData newLocationData) {
    setState(() {
      currentLocation = newLocationData;
    });
    animateCameraToNewLocation(newLocationData);
    LocationUpdater().updateLocation(newLocationData);
  }

  void getCabIcon() async {
    cabIcon = await IconUtils.createMarkerImageFromAsset();
  }

  void animateCameraToNewLocation(LocationData newLocation) {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(newLocation.latitude!, newLocation.longitude!),
        zoom: newZoom)));
  }

  @override
  void initState() {
    super.initState();
    getCabIcon();
    setup();
  }

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPIKey,
      PointLatLng(defaultLocation.latitude!, defaultLocation.longitude!),
      PointLatLng(
        destinationLocation.latitude!,
        destinationLocation.longitude!,
      ),
      travelMode: TravelMode.driving,
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });

      setState(() {
        _polylines.add(Polyline(
            width: 2, // set the width of the polylines
            polylineId: PolylineId("poly"),
            color: Color.fromARGB(255, 40, 122, 198),
            points: polylineCoordinates));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(right: 20, left: 20, top: 5),
      decoration: BoxDecoration(
        borderRadius: borderRadiusCard,
        boxShadow: [
          boxShadowCard,
        ],
        color: white,
      ),
      child: Column(
        children: [
          Container(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: radiusCard, topRight: radiusCard),
                color: CupertinoColors.systemYellow,
              ),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(
                        defaultLocation.latitude!, defaultLocation.longitude!),
                    zoom: defaultZoom),
                markers: currentLocation == null
                    ? Set()
                    : [
                        Marker(
                          icon: cabIcon,
                          markerId: MarkerId(defaultMarkerId),
                          position: LatLng(currentLocation.latitude!,
                              currentLocation.longitude!),
                        ),
                        Marker(
                            markerId: MarkerId('sourcePin'),
                            position: LatLng(defaultLocation.latitude!,
                                defaultLocation.longitude!),
                            onTap: () {
                              // setState(() {
                              //   currentlySelectedPin = sourcePinInfo;
                              //   pinPillPosition = 0;
                              // });
                            },
                            icon: sourceIcon),
                        Marker(
                            markerId: MarkerId('destPin'),
                            position: LatLng(destinationLocation.latitude!,
                                destinationLocation.longitude!),
                            onTap: () {
                              setState(() {
                                // currentlySelectedPin = destinationPinInfo;
                                // pinPillPosition = 0;
                              });
                            },
                            icon: destinationIcon)
                      ].toSet(),
                onMapCreated: (GoogleMapController controller) {
                  setPolylines();
                  setState(() {
                    _controller = controller;
                  });
                },
              ),
            ),
          ),
          Container(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 20, 0),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.airplane,
                          color: blackColor,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.0),
                          child: Text(
                            'Tour',
                            style: TextStyle(
                                fontSize: smallText,
                                color: blackColor,
                                fontFamily: sfproregular),
                          ),
                        ),
                        Spacer(),
                        Text(
                          'FRA-175493136',
                          style: TextStyle(
                              fontSize: smallText,
                              color: blackColor,
                              fontFamily: sfproregular),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 20, 20),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.cart_fill,
                          color: blackColor,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.0),
                          child: Text('Fracht',
                              style: TextStyle(
                                  fontSize: smallText,
                                  color: blackColor,
                                  fontFamily: sfproregular)),
                        ),
                        Spacer(),
                        Text(
                          '7.325,5 kg',
                          style: TextStyle(
                              fontSize: smallText,
                              color: blackColor,
                              fontFamily: sfproregular),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 35, 20, 0),
                  child: Text(
                    'Aktuell Geladen',
                    style: TextStyle(
                        fontSize: smallText,
                        color: grayOpacityTextColor,
                        fontFamily: sfproregular),
                  ),
                ),
              ],
            ),
          ),
          Divider(),
          Container(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 20, 20),
                    child: Row(
                      children: [
                        Icon(
                          CupertinoIcons.cube_box_fill,
                          color: blackColor,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 2.0),
                          child: Text(
                            'Packstücke',
                            style: TextStyle(
                                fontSize: smallText,
                                color: blackColor,
                                fontFamily: sfproregular),
                          ),
                        ),
                        Spacer(),
                        Text(
                          '32 pcs',
                          style: TextStyle(
                              fontSize: smallText,
                              color: blackColor,
                              fontFamily: sfproregular),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 35, 20, 10),
                  child: Text(
                    'Aktuell Geladen',
                    style: TextStyle(
                        fontSize: smallText,
                        color: grayOpacityTextColor,
                        fontFamily: sfproregular),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
