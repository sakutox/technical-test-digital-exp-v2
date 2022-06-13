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
}
