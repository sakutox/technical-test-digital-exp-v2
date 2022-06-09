import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:technical_testv2/provider.dart';
import 'package:technical_testv2/screens/mainScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => MyProvider())],
      child: const MaterialApp(title: 'Material App', home: MainScreen()),
    );
  }
}
