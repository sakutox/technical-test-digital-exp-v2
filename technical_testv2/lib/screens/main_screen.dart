import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _styleText(double size) {
      return TextStyle(fontSize: size);
    }

    final topPart = SizedBox(
      width: MediaQuery.of(context).size.width * 0.8,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Login Account",
            style: _styleText(20),
          ),
          Text("Hello, Welcome back again", style: _styleText(15)),
        ],
      ),
    );

    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.08),
      child: Column(
        children: [
          topPart,
        ],
      ),
    ));
  }
}
