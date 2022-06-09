import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:technical_testv2/provider.dart';
import 'package:technical_testv2/screens/main_screen.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => MyProvider())],
      child: MaterialApp(
        title: 'Material App',
        home: const MainScreen(),
        theme: ThemeData(fontFamily: 'Montserrat'),
      ),
    );
  }
}
