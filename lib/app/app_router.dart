import 'package:flutter/material.dart';
import 'package:untitled04/screens/home_screen.dart';
import 'app_route_names.dart';

class AppRouter{
  static Route? onGenerateRoute(RouteSettings routeSettings,){
    switch (routeSettings.name){
      case AppRouteNames.homeScreenRoute:
        return _routeTo(() => const HomeScreen(),);
      default:
        return null;
    }
  }

  static Route? _routeTo(Widget Function() widgetFunction,){
    return MaterialPageRoute(
      builder: (_,) => widgetFunction(),
    );
  }
}