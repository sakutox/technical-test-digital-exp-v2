import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VariatedUtils {
  static height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static textStyleUtil(double size, Color color) {
    return TextStyle(
        fontFamily: 'Montserrat',
        fontSize: size,
        color: color,
        overflow: TextOverflow.clip);
  }

  static inputDecorationUtil(String etiqueta) {
    return InputDecoration(
        floatingLabelAlignment: FloatingLabelAlignment.center,
        hintText: etiqueta,
        hintStyle: textStyleUtil(12, Colors.grey),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)));
  }

  static personalizedSizedBox(double height) {
    return SizedBox(
      height: height,
    );
  }

  static personalizedSizedBoxWidth(double width) {
    return SizedBox(
      width: width,
    );
  }

  static bool integerLengthVerification(String number, int size) {
    RegExp exp = RegExp(r'^[0-9]+$');
    bool flag = false;

    if (number.length != size) {
      Fluttertoast.showToast(msg: 'Number is not $size digits long');
    } else if (exp.hasMatch(number) == false) {
      Fluttertoast.showToast(msg: 'Number contains invalid characters');
    } else {
      flag = true;
    }
    return flag;
  }

  static bool emailVerification(String email) {
    RegExp exp = RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]");
    bool flag = false;
    if (exp.hasMatch(email) == false) {
      Fluttertoast.showToast(msg: 'Invalid email');
    } else {
      flag = true;
    }
    return flag;
  }

  static bool nameVerification(String name) {
    bool flag = false;
    
    if (RegExp(r"^[\p{L} ,.'-]*$",
            caseSensitive: false, unicode: true, dotAll: true)
        .hasMatch(name)) {
      flag = true;
    }

    return flag;
  }
}
