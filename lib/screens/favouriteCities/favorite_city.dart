// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adhan_app/screens/favouriteCities/prayer_time.dart';
import 'package:adhan_app/theme/pallete.dart';
import 'package:flutter/material.dart';

class FavoriteCity extends StatelessWidget {
  String cityName = "";

  static route(BuildContext context, String name) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoriteCity(name),
      ),
    );
  }

  FavoriteCity(this.cityName, {super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(cityName),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Pallete.blackColor,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrayerTime(
                  height: height, width: width, prayer: "Fajr", time: "05:23 AM"),
              PrayerTime(
                  height: height, width: width, prayer: "Zuhr", time: "11:53 AM"),
              PrayerTime(
                  height: height, width: width, prayer: "Asr", time: "03:10 PM"),
              PrayerTime(
                  height: height, width: width, prayer: "Maghrib", time: "05:37 PM"),
              PrayerTime(
                  height: height, width: width, prayer: "Isha", time: "07:07 PM"),
            ],
          ),
        ));
  }
}


