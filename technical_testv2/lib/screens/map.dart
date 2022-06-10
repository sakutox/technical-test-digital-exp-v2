import 'dart:async';
import 'package:flutter/material.dart';
import 'package:technical_testv2/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// ignore: depend_on_referenced_packages

class MapScreen extends StatelessWidget {
  MapScreen({Key? key}) : super(key: key);
  Completer<GoogleMapController> _controller = Completer();

  static CameraPosition cameraFocus = const CameraPosition(
    target: LatLng(7.113246, -73.107494),
    zoom: 14.4746,
  );

  buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: cameraFocus,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
      markers: {
        const Marker(
            markerId: MarkerId('markerId'),
            position: LatLng(7.113246, -73.107494))
      },
    );
  }

  searchBar(BuildContext context) {
    return Container(      
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50), color: Colors.white, boxShadow: [BoxShadow(blurRadius: 5,color: Colors.black12, offset: Offset(2,2))]),
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
        margin: EdgeInsets.all(MediaQuery.of(context).size.width*0.05),
        height: VariatedUtils.height(context)*0.06,
        child: const TextField(
          keyboardType: TextInputType.streetAddress,
          decoration: InputDecoration(border: InputBorder.none),
        ));
  }

  Future<Marker> showMarker() async {
    return Marker(
        markerId: const MarkerId('1'),
        position: const LatLng(7.113246, -73.107494),
        icon: await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(size: Size(48, 48)),
            'assets/images/pin.png'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        showMarker();
      }),
      body: SafeArea(
        child: SizedBox(
          height: VariatedUtils.height(context),
          width: VariatedUtils.width(context),
          child: Stack(
            children: [
              buildMap(),
              Column(
                children: [searchBar(context)],
              )
            ],
          ),
        ),
      ),
    );
  }
}
