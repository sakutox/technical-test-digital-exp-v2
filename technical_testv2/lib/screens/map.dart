import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:technical_testv2/providers/provider.dart';
import 'package:technical_testv2/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  MapScreen({Key? key}) : super(key: key);
  Completer<GoogleMapController> _controller = Completer();

  static CameraPosition cameraFocus = const CameraPosition(
    target: LatLng(7.113246, -73.107494),
    zoom: 14.4746,
  );

  buildMap(BuildContext context, MyProvider provider) {
    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: cameraFocus,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: {provider.location}
        // {const Marker(markerId: MarkerId('current location'), position: LatLng(provider.location.latitude, provider.location.latitude));},
        );
  }

  searchBar(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.white,
            // ignore: prefer_const_literals_to_create_immutables
            boxShadow: [
              const BoxShadow(
                  blurRadius: 5, color: Colors.black12, offset: Offset(2, 2))
            ]),
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.015),
        margin: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
        height: VariatedUtils.height(context) * 0.06,
        child: Row(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            VariatedUtils.personalizedSizedBoxWidth(5),
            const Flexible(
              flex: 200,
              child: TextField(
                keyboardType: TextInputType.streetAddress,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            const Flexible(
                flex: 20,
                child: InkWell(
                  child: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ))
          ],
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

  _determinePosition(MyProvider provider) async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    try {
      provider.getLocation(await Geolocator.getCurrentPosition());
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    MyProvider provider = Provider.of<MyProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            _determinePosition(provider);
          },
          child: const Icon(Icons.location_on)),
      body: SafeArea(
        child: SizedBox(
          height: VariatedUtils.height(context),
          width: VariatedUtils.width(context),
          child: Stack(
            children: [
              buildMap(context, provider),
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
