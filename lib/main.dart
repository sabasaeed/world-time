import 'package:flutter/material.dart';
import 'package:time_app/screens/home_screen.dart';
import 'package:time_app/screens/loading_screen.dart';

void main() {
  runApp(const TimeApp());
}

class TimeApp extends StatefulWidget {
  const TimeApp({Key? key}) : super(key: key);

  @override
  _TimeAppState createState() => _TimeAppState();
}

class _TimeAppState extends State<TimeApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/Loading',
      routes: {
        '/home': (context) => Home(),
        '/Loading': (context) => LoadingScreen()
      },
    );
  }
}
