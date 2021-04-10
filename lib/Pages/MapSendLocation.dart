import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:taxis_app/Business/Provider/TaxiProvider.dart';
import 'package:taxis_app/Core/ApiFirebase.dart';
import 'package:taxis_app/Core/ApiUbication.dart';
import 'package:taxis_app/Core/User_Preferens.dart';
class MapSendLocation extends StatefulWidget {

  @override
  _MapSendLocationState createState() => _MapSendLocationState();
}

class _MapSendLocationState extends State<MapSendLocation> {
  UserPreferences prefs = UserPreferences();
  Position position;
  ApiUbication apiUbication = ApiUbication();

  ApiFirebase apiFirebase = ApiFirebase();
  TaxiProvider taxiProvider;
  
  CollectionReference taxis = FirebaseFirestore.instance.collection('taxis');

  // StreamController streamController;

  // void onPauseHandler() {
  //   print('on Pause');
  // }
  // 
  StreamSubscription<Position> positionStream;
  int i = 0;

  
  @override
  void initState() { 
    super.initState();
    taxiProvider = Provider.of<TaxiProvider>(context,listen: false);
    apiFirebase.consultaTaxis(taxiProvider);
    // getUbication();
    cargarMarker();
    // positionStream = Geolocator.getPositionStream(
    //   desiredAccuracy: LocationAccuracy.best,
    //   distanceFilter: 2,
    //   // intervalDuration: Duration(seconds: 1),
    //   // forceAndroidLocationManager: true
    //   // timeInterval: 1
    // ).listen(
    //   (Position position) {
    //       _markers = {};
    //       this.position = position;
    //       i = i+1;
    //       print(position == null ? 'Unknown' : 
    //         position.latitude.toString() + ', ' + 
    //         position.longitude.toString() + ' __ ' +
    //         position.floor.toString()  + ' __ ' +
    //         position.accuracy.toString()  + ' __ ' +
    //         position.altitude.toString()  + ' __ ' +
    //         position.heading.toString()  + ' __ ' +
    //         position.isMocked .toString()  + ' __ ' +
    //         position.speed.toString()  + ' __ ' +
    //         position.speedAccuracy.toString()  + ' __ ' +
    //         position.timestamp.toString()
    //       );
    //       if(position != null){
    //         setState(() {
    //           _markers.add(
    //           Marker(
    //             markerId: MarkerId("MIMARCADOR"),
    //             position: LatLng(position.latitude,position.longitude ),
    //             icon: markerBitMap,
    //             )
    //           );
    //           try {
    //             // mapController.animateCamera(CameraUpdate.newCameraPosition(
    //             // CameraPosition(target: LatLng(position.latitude,position.longitude ), zoom: 16),
    //             // )); 
    //             print("========== ${prefs.userFirebaseId}");
    //             taxis
    //             .doc("${prefs.userFirebaseId}")
    //             .set({
    //               'latitude':position.latitude.toString(),
    //               'longitude':position.longitude.toString(),
    //               'floor':position.floor.toString(),
    //               'accuracy':position.accuracy.toString(),
    //               'altitude':position.altitude.toString(),
    //               'heading':position.heading.toString(),
    //               'isMocked':position.isMocked .toString(),
    //               'speed':position.speed.toString(),
    //               'speedAccuracy':position.speedAccuracy.toString(),
    //               'timestamp':position.timestamp.toString(),
    //             })
    //             .then((value) => print("taxi Updated"))
    //             .catchError((error) => print("Failed to update taxi: $error"));
    //           } catch (e) {
    //             print("############ $e #############");
    //           }
    //         });


    //       }
    //   });


  }

  // Declarado fuera del metodo Build
  GoogleMapController mapController;

  @override
  void dispose() { 
    positionStream.cancel();
    super.dispose();
  }


  BitmapDescriptor markerBitMap;
  cargarMarker()async{
     markerBitMap = await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),'src/icons/car.png');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    taxiProvider = Provider.of<TaxiProvider>(context,listen: true);
    print("============DIDCHANGE===========");
    readMarkers();
  }

  readMarkers(){
    _markers={};
    setState(() {
      
    });
    taxiProvider.listaTaxis?.forEach((element) {
      print("####___");
      _markers.add(
        Marker(
          markerId: MarkerId("prueba"),
          position: LatLng(element.latitude,element.longitude ),
          icon: markerBitMap,
          )
        );
    });

    setState(() {
      
    });
  }

  getUbication()async{
    try {
      position = await apiUbication.determinePosition();
      print("===> $position");
      try {
        mapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(position.latitude,position.longitude ), zoom: 16),
        )); 
      } catch (e) {
      }
      setState(() {});  
    } catch (e) {
    }
  }

  CameraPosition positionMap = CameraPosition(
    target: LatLng(-16.482557865279468, -68.1214064732194),
    zoom: 16
  );

  // Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.grey[50],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: positionMap,
                  markers: _markers,
                  myLocationEnabled: true,
                  trafficEnabled: false,
                  indoorViewEnabled: false,
                  myLocationButtonEnabled: true,
                  minMaxZoomPreference: MinMaxZoomPreference(12, 18.6),
                  rotateGesturesEnabled: false,
                  scrollGesturesEnabled: true,
                  tiltGesturesEnabled: false,
                  onMapCreated: (controller) {
                    // _controller.complete(controller);
                    mapController = controller;
                    rootBundle.loadString('assets/mapStyle.txt').then((string) {
                      mapController.setMapStyle(string);  
                    });
                  },
                ),
              ),
              Text("  == Datos transferidos           = $i ="),
              if(position?.latitude!=null)Text("  == latitude                = ${position.latitude} ="),
              if(position?.longitude!=null)Text("  == longitude              = ${position.longitude} ="),
              if(position?.floor!=null)Text("  == floor                      = ${position.floor} ="),
              if(position?.accuracy!=null)Text("  == accuracy                = ${position.accuracy} ="),
              if(position?.altitude!=null)Text("  == altitude                   = ${position.altitude} ="),
              if(position?.heading!=null)Text("  == heading                   = ${position.heading} ="),
              if(position?.isMocked!=null)Text("  == isMocked                = ${position.isMocked} ="),
              if(position?.speed!=null)Text("  == speed                      = ${position.speed} "),
              if(position?.speedAccuracy!=null)Text("  == speedAccuracy      = ${position.speedAccuracy} ="),
              if(position?.timestamp!=null)Text("  == timestamp              = ${position.timestamp} ="),

            ],
          ),
        ),
      ),
    );
  }

  // markersFromList(){
  //   _markers={};

  //   taxiProvider.listaTaxis.forEach((element) {
  //     _markers.add(
  //       Marker(
  //         markerId: MarkerId(element.timestamp),
  //         position: LatLng(position.latitude,position.longitude ),
  //         icon: markerBitMap,
  //         )
  //       );
  //   });
  // }

  //////////////////////////////////////////////
  ///
  Set<Marker> _markers = {};
  
}