import 'package:flutter/material.dart';
import 'package:movies_app/screens/screens.dart';

abstract class AppRoutes {
  static const String home = 'home';
  static const String details = 'details';
  static const String initialRoute = home;

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      home: (context) => const HomeScreen(),
      details: (context) => const DetailsScreen(),
    };
  }
}
