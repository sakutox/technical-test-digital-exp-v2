import 'package:flutter/material.dart';
import 'package:technical_testv2/features/user_access/display/screens/phone_access.dart';
import 'package:technical_testv2/screens/main_screen.dart';
import 'package:technical_testv2/screens/map.dart';
import 'package:technical_testv2/screens/otp.dart';
import 'package:technical_testv2/screens/register.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case '/otp_screen':
        if (args is String) {
          return MaterialPageRoute(builder: (_) => OtpScreen(phone: args));
        } else {
          return _errorRoute();
        }
      case '/map_screen':
        return MaterialPageRoute(builder: (_) => MapScreen());
      case '/register':
        if (args is String) {
          return MaterialPageRoute(builder: (_) => Register(phone: args));
        } else {
          return _errorRoute();
        }
      case '/phone_access':
        return MaterialPageRoute(builder: (_) => const PhoneAccess());

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
