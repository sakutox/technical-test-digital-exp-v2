import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyProvider with ChangeNotifier {
  int number = 0;
  Marker location = const Marker(
      markerId: MarkerId('xd'), position: LatLng(7.1168123, -73.1074555));

  CameraPosition cameraFocus = const CameraPosition(
    target: LatLng(7.1168123, -73.1074555),
    zoom: 17,
  );

  late GoogleMapController controller;

  void myFunction() {
    number++;
    notifyListeners();
  }

  void getLocation(Position location2) {
    location = Marker(
        markerId: const MarkerId('value'),
        position: LatLng(location2.latitude, location2.longitude));

    notifyListeners();
  }

  Future<void> changeCameraFocus(Position location2) async {
    cameraFocus = CameraPosition(
      target: LatLng(location2.latitude, location2.longitude),
      zoom: 17,
    );

    await controller.animateCamera(CameraUpdate.newCameraPosition(cameraFocus));

    notifyListeners();
  }

  verifyPhoneNumber(BuildContext context, String phoneNumber) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+57$phoneNumber',
      verificationCompleted: (PhoneAuthCredential credential) async {
        // await auth.signInWithCredential(credential);
        Navigator.of(context).pushReplacementNamed('/map_screen');
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          Fluttertoast.showToast(
              msg: 'The provided phone number is not valid.');
        }
        Fluttertoast.showToast(msg: '$e');
      },
      codeSent: (String verificationId, int? resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
        String smsCode = '123456';

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: smsCode);

        // Sign the user in (or link) with the credential
        // await auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
