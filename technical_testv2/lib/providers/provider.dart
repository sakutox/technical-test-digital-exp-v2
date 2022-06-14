import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:technical_testv2/models/user_firebase.dart';

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
  FirebaseFirestore db = FirebaseFirestore.instance;

  late GoogleMapController controller;
  late FirebaseAuth auth = FirebaseAuth.instance;
  UserFirebase userProvider = UserFirebase();

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
        try {
          UserCredential userCredential =
              await auth.signInWithCredential(credential);

          // ignore: use_build_context_synchronously
          userCreatedVerification(userCredential, context, phoneNumber);
        } catch (e) {
          Fluttertoast.showToast(msg: '$e');
        }
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

  verifyPhoneNumberAgain(String verificationId, String smsCode,
      BuildContext context, String phoneNumber) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);

    try {
      UserCredential userCredential =
          await auth.signInWithCredential(credential);

      // ignore: use_build_context_synchronously
      userCreatedVerification(userCredential, context, phoneNumber);
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }

  userCreatedVerification(UserCredential userCredential, BuildContext context,
      String phoneNumber) async {
    if (userCredential.user != null) {
      DocumentSnapshot snapshot =
          await db.collection('users').doc(userCredential.user!.uid).get();
          userProvider.uid = userCredential.user!.uid;
      if (snapshot.exists) {
        Fluttertoast.showToast(msg: 'Bienvenido devuelta ${snapshot.get('name').toString().toUpperCase()}');
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacementNamed('/map_screen');
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamed('/register', arguments: phoneNumber);
      }
    }
  }
}
