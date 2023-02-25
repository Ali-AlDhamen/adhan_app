import 'package:flutter/material.dart';

import '../../../theme/pallete.dart';

class PrayerTime extends StatelessWidget {
  final double height;
  final double width;
  final String prayer;
  final String time;

  const PrayerTime(
      {super.key, required this.height,
      required this.width,
      required this.prayer,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: height * 0.02,
      ),
      width: width * 0.8,
      height: height * 0.08,
      decoration: BoxDecoration(
        color: Pallete.grayColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              prayer,
              style: const TextStyle(
                  color: Pallete.purpleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              time,
              style: const TextStyle(
                  color: Pallete.purpleColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}