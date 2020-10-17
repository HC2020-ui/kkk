import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:search_map_place/search_map_place.dart';
import 'dart:async';
import 'package:winkl/config/theme.dart';
import 'package:winkl/loading.dart';

class Gps extends StatefulWidget {
  @override
  _GpsState createState() => _GpsState();
}

class _GpsState extends State<Gps> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Completer<GoogleMapController> _controller = Completer();
  double latitude;
  double longitude;
  String location ;
  String pin;
  String area;
  String locality;
  String sublocality;
  LatLng pinPosition;
  BitmapDescriptor pinLocationIcon;

  GoogleMapController mapController;

  Set<Marker> _markers = {};
  bool _isDone = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcurrentposition();
  }

  getcurrentposition() async {
    pinLocationIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(devicePixelRatio: 2.5), 'images/destination.png');
    Position position = await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    latitude = position.latitude;
    longitude = position.longitude;

    final placemark = await placemarkFromCoordinates(latitude, longitude);

    setState(() {
      pinPosition = LatLng(latitude, longitude);
      _isDone = true;
      location = placemark[0].locality.toUpperCase();
      pin = placemark[0].postalCode.toString();
      area = placemark[0].administrativeArea.toString();
      locality = placemark[0].locality.toString();
      sublocality= placemark[0].subLocality.toString();

      print(location);
//      print(name);
      print(locality);
      print(area);
      print(sublocality);
//      print(placemark[0].thoroughfare);
      print(placemark[0].subThoroughfare);
//      placemark[0].a
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          key: _scaffoldKey,
          body: _isDone
              ? Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(latitude, longitude),
                        zoom: 15,
                      ),
                      markers: _markers,
                      onMapCreated: onMapCreated,
                    ),

//            Positioned(
//             top: MediaQuery.of(context).size.height-650,
//              left: 20.0,
//              child: SearchMapPlaceWidget(
//                apiKey1: "AIzaSyCy6I1SleZ42NlSTDVDoKx1S6r4_vEeMNw",
                  // apikey2 - AIzaSyDgMCG9TP7ljV03GCqImXby3QBtq5MyoME,
//                // The language of the autocompletion
//                language: 'en',
//                // The position used to give better recommendations. In this case we are using the user position
//                location: LatLng(latitude,longitude),
//                radius: 30000,
//                onSelected: (Place place)async{
//                  final geolocation = await place.geolocation;
//                  print(geolocation.coordinates);
//                },
//                onSearch: (Place place){
//                  print(place.geolocation);
//                  print('hello');
//                },
//
//              ),
//            ),
                  ],
                )
              : Loading()
//        floatingActionButton: FloatingActionButton.extended(onPressed: null, label: null),
          );
  }

  void onMapCreated(controller) {
    _controller.complete(controller);
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('Location $latitude + $longitude'),
          position: pinPosition,
          icon: pinLocationIcon,
          onTap: showSnackbar,
          infoWindow: InfoWindow(title: location)));
    });
  }

  void showSnackbar() {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        backgroundColor: AppColors.orange,
        duration: Duration(seconds: 5),
        content: Container(
          child: Row(children: [
            Text('is this your desire location ?'),
            SizedBox(
              width: 15,
            ),
            GestureDetector(
              child: Text('Yes'),
              onTap: () {
                Navigator.pop(context, location+', $pin'+', $area'+', $locality' +', $sublocality');
              },
            ),
            SizedBox(
              width: 15,
            ),
            Text('No'),
          ]),
        )));
  }
}
