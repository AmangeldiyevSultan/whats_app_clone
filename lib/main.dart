import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:whats_app_clone/Screens/Homescreen.dart';
import 'Screens/CameraScreen.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: "OpenSans"
      ),
      home: const HomeScreen(),
    );
  }
}
