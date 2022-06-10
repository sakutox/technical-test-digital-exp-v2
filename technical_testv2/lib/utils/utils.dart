import 'package:flutter/material.dart';

class VariatedUtils {
  static height(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static textStyleUtil(double size, Color color) {
    return TextStyle(fontFamily: 'Montserrat', fontSize: size, color: color);
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
}
