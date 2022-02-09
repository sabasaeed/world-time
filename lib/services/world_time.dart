import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:time_app/services/time_helper.dart';

class WorldTimeService {
  var time;

  var location;
  var isDayTime;
  var url;
  var offset;
  var greetingText;

  WorldTimeService(
      {this.isDayTime,
      this.location,
      this.time,
      this.url,
      this.offset,
      this.greetingText});

  Future<void> getTime() async {
    try {
      Response response =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(response.body);

      var dateTime = data['utc_datetime'];

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(seconds: offset));

      time = DateFormat.jm().format(now);

      isDayTime = TimeHelper.isDayTime(now);
      greetingText = "Good " + TimeHelper.getTimeOfDay(now);
    } catch (e) {
      print('Caught error : $e');
      print(e);
      isDayTime = true;
      time = '';
      greetingText = 'Sorry,Could not get Time!';
    }
  }
}
