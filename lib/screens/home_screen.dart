import 'package:flutter/material.dart';
import 'package:untitled04/app/app_route_names.dart';
import 'package:untitled04/screens/recording_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: TextButton(
                onPressed: () => Navigator.of(context,).push(
                  MaterialPageRoute(builder: (_,) => const RecordingScreen(),),
                ),
                child: const Text("Recording Page", style: TextStyle(color: Colors.white,),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}