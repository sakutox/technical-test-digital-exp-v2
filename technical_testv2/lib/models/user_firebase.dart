import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class UserFirebase {
  String? uid;
  String? name;
  String? email;
  String? phone;

  UserFirebase({this.uid, this.name, this.email, this.phone});

  var collection = FirebaseFirestore.instance.collection('users');

  getUser() async {
    List<UserFirebase> users = [];

    var querySnapshot = await collection.get();

    for (var queryDocumentSnaphot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnaphot.data();
      users.add(UserFirebase(
          uid: data['uid'],
          email: data['email'],
          name: data['name'],
          phone: data['phone']));
    }

    return users;
  }

  createUser(UserFirebase user, BuildContext context) async {
    try {
      await collection.doc(user.uid).set(user.toJson());
      Fluttertoast.showToast(msg: 'Account created succesfully');

      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed('/map_screen');
    } catch (e) {
      Fluttertoast.showToast(msg: '$e');
    }
  }

  factory UserFirebase.fromJson(Map<String, dynamic> map) {
    return UserFirebase(
        uid: map['uid'],
        name: map['name'],
        email: map['email'],
        phone: map['phone']);
  }

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'name': name, 'email': email, 'phone': phone};
  }
}
