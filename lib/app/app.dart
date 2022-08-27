import 'dart:developer';
import 'package:flutter/material.dart';
import 'app_route_names.dart';
import 'app_router.dart';

class MyApp extends StatelessWidget {
  const MyApp() : super(key: null,);

  @override
  Widget build(BuildContext context,) {
    return MaterialApp(
      title: 'Homework Task',
      builder: (BuildContext buildContext, Widget? child,) {
        return SafeArea(
          child: child!,
        );
      },
      initialRoute: AppRouteNames.homeScreenRoute,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
