import 'package:flutter/material.dart';

import '../../common/helper.dart';
import '../../theme/pallete.dart';

class PrayerTimeHome extends StatelessWidget {
  final String name;
  final String time;
  const PrayerTimeHome({super.key, required this.name, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Pallete.grayColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            name,
            style: const TextStyle(
                color: Pallete.purpleColor, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            Helper.getFormattedTimeAMPM(time),
            style: const TextStyle(
                color:  Pallete.purpleColor, fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
