import 'package:adhan_app/screens/test.dart';
import 'package:adhan_app/theme/pallete.dart';
import 'package:flutter/material.dart';

import '../favouriteCities/prayer_time.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        children: [
          Container(
            width: width * 0.9,
            height: height * 0.05,
            margin: const EdgeInsets.only(top: 20.0),
            decoration: BoxDecoration(
              color: Pallete.grayColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const TextField(
              style: TextStyle(color: Colors.white),
              cursorColor: Pallete.purpleColor,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Pallete.purpleColor),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Riyadh",
                style: TextStyle(
                    color: Pallete.purpleColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border_rounded,
                    color: Colors.white, size: 30),
              ),
            ],
          ),
          SizedBox(
            height: height * 0.05,
          ),
          PrayerTime(
              height: height, width: width, prayer: "Fajr", time: "05:23 AM"),
          PrayerTime(
              height: height, width: width, prayer: "Zuhr", time: "11:53 AM"),
          PrayerTime(
              height: height, width: width, prayer: "Asr", time: "03:10 PM"),
          PrayerTime(
              height: height,
              width: width,
              prayer: "Maghrib",
              time: "05:37 PM"),
          PrayerTime(
              height: height, width: width, prayer: "Isha", time: "07:07 PM"),
        ],
      ),
    );
  }
}
