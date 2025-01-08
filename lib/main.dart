import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:travel_app/screens/home.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  MapboxOptions.setAccessToken(dotenv.get("MAPBOX_TOKEN"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Travel',
      home: HomeScreen(),
      // home: MapWidget(
      //   cameraOptions: CameraOptions(
      //       center: Point(coordinates: Position(-98.0, 39.5)),
      //       zoom: 2,
      //       bearing: 0,
      //       pitch: 0),
      // ),
    );
  }
}
