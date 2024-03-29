import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:technical_testv2/core/firebase_config/firebase_initialize_app.dart';
import 'package:technical_testv2/features/map/display/providers/map_provider.dart';
import 'package:technical_testv2/features/user_access/display/providers/user_access_provider.dart';
import 'package:technical_testv2/routes/routes.dart';
import 'package:technical_testv2/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  await FirebaseConfig.firebaseInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserAccessProvider()),
        ChangeNotifierProvider(create: (context) => MapProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteGenerator.generateRoute,
        initialRoute: '/phone_access',
        title: 'Material App',
        home: const MainScreen(),
        theme: ThemeData(fontFamily: 'Montserrat'),
      ),
    );
  }
}
