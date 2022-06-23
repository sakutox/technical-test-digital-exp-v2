import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:technical_testv2/features/map/display/providers/map_provider.dart';
import 'package:technical_testv2/utils/utils.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class MapScreenCleanArq extends StatelessWidget {
  MapScreenCleanArq({Key? key}) : super(key: key);
  TextEditingController addressController = TextEditingController();

  buildMap(BuildContext context, MapProvider provider) {
    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: provider.cameraFocus,
        onMapCreated: (GoogleMapController controller) {
          provider.googleMapController = controller;
        },
        markers: {provider.location});
  }

  searchBar(BuildContext context, MapProvider provider) {
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
            Flexible(
              flex: 200,
              child: TextField(
                controller: addressController,
                keyboardType: TextInputType.streetAddress,
                decoration: const InputDecoration(border: InputBorder.none),
              ),
            ),
            Flexible(
                flex: 20,
                child: InkWell(
                  onTap: () async {
                    try {
                      List<Location> locations = await locationFromAddress(
                          '${addressController.text} Bucaramanga, Santander');

                      Position position = Position(
                          longitude: locations[0].longitude,
                          latitude: locations[0].latitude,
                          timestamp: DateTime.now(),
                          accuracy: 0,
                          altitude: 0,
                          heading: 0,
                          speed: 0,
                          speedAccuracy: 0);

                      provider.getLocation(position);

                      provider.changeCameraFocus(position);
                    } catch (e) {
                      Fluttertoast.showToast(msg: '$e');
                    }
                  },
                  child: const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ))
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    MapProvider mapProvider = Provider.of<MapProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            mapProvider.determinePosition(mapProvider);
          },
          child: const Icon(Icons.location_on)),
      body: SafeArea(
        child: SizedBox(
          height: VariatedUtils.height(context),
          width: VariatedUtils.width(context),
          child: Stack(
            children: [
              buildMap(context, mapProvider),
              Column(
                children: [searchBar(context, mapProvider)],
              )
            ],
          ),
        ),
      ),
    );
  }
}
