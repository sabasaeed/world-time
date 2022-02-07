import 'package:flutter/material.dart';
import 'package:time_app/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  Map data = {};
  @override
  initState() {
    super.initState();

    setUpInitialCall();
  }

  void setUpInitialCall() async {
    WorldTimeService instance = WorldTimeService(
        location: 'Pakistan', url: 'Asia/Karachi', offset: 18000);
    await instance.getTime();

    data = {
      'location': instance.location,
      'time': instance.time,
      'url': instance.url,
      'flag': instance.flag,
      'isDayTime': instance.isDayTime,
      'greetingText': instance.greetingText
    };

    Navigator.pushNamed(context, '/home', arguments: data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            ' World Time ',
            style: TextStyle(fontSize: 30, color: Colors.blueGrey[200]),
          ),
          const SizedBox(
              height: 100,
              width: 100,
              child: Image(image: AssetImage('images/world_time_logo.png'))),
          SpinKitRipple(
            color: Colors.blueGrey[200],
            size: 50.0,
          )
        ],
      ),
    );
  }
}
