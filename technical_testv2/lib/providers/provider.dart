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
  String verificationIdUser = '';
  String otpCode = '';

  late GoogleMapController controller;
  late FirebaseAuth auth = FirebaseAuth.instance;

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
        verificationIdUser = verificationId;
        Navigator.of(context)
            .pushReplacementNamed('/otp_screen', arguments: phoneNumber);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  verifyPhoneNumberAgain(
      String verificationId, String smsCode, BuildContext context) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    try {
      await auth.signInWithCredential(credential);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed('/map_screen');
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }
}
