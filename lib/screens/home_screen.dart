import 'dart:io';

import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:time_app/services/Utils.dart';
import 'package:time_app/services/world_time.dart';
import 'package:time_app/resources/time_zones.dart';
import 'package:move_to_background/move_to_background.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {};

  Country selectedCountry = Country(
    phoneCode: '',
    countryCode: 'PK',
    e164Sc: 1,
    geographic: false,
    level: 1,
    name: 'Pakistan',
    example: '',
    displayName: 'Pakistan (PK)',
    displayNameNoCountryCode: 'Pakistan',
    e164Key: '92-PK-0',
  );

  void fetchCurrentTime(location, url, offset, countryItem) async {
    WorldTimeService instance =
        WorldTimeService(location: location, url: url, offset: offset);
    await instance.getTime();

    setState(() {
      data = {
        'location': instance.location,
        'time': instance.time,
        'url': instance.url,
        'flag': instance.flag,
        'isDayTime': instance.isDayTime
      };
      selectedCountry = countryItem;
    });
  }

  @override
  Widget build(BuildContext context) {
    data =
        data.isEmpty ? ModalRoute.of(context)!.settings.arguments as Map : data;

    var bgImage = data['isDayTime'] ? 'images/day.jpg' : 'images/night.jpg';
    return WillPopScope(
      onWillPop: () async {
        MoveToBackground.moveTaskToBack();
        return false;
      },
      child: MaterialApp(
        home: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(bgImage), fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Padding(
              padding: const EdgeInsets.fromLTRB(0, 150, 0, 0),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      showCountryPicker(
                        context: context,
                        showPhoneCode:
                            false, // optional. Shows phone code before the country name.
                        onSelect: (Country countryItem) {
                          var timeZone = countryTimeZones.firstWhere(
                              (element) =>
                                  element['countryCode'] ==
                                  countryItem.countryCode);

                          fetchCurrentTime(
                              timeZone['countryName'],
                              timeZone['zoneName'],
                              timeZone['gmtOffset'],
                              countryItem);
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.edit_location,
                      color: Colors.grey,
                    ),
                    label: const Text('Change Location'),
                    style:
                        ElevatedButton.styleFrom(primary: Colors.transparent),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Utils.countryCodeToEmoji(selectedCountry.countryCode),
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          data['location'],
                          style: TextStyle(
                              color: (data['isDayTime'] as bool)
                                  ? Colors.blue[900]
                                  : Colors.blueGrey[200],
                              fontSize: 20,
                              fontFamily: 'Roboto'),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      data['time'],
                      style: TextStyle(
                          fontSize: 36,
                          color: (data['isDayTime'] as bool)
                              ? Colors.blue[900]
                              : Colors.blueGrey[200],
                          fontFamily: 'Roboto'),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
