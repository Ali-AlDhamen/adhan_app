import 'package:adhan_app/common/helper.dart';
import 'package:adhan_app/providers/prayers_time_provider.dart';

import 'package:adhan_app/screens/Home/home_date.dart';
import 'package:adhan_app/screens/Home/prayer_time_home.dart';
import 'package:adhan_app/services/location.dart';
import 'package:adhan_app/services/prayers_api.dart';
import 'package:adhan_app/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:adhan_app/services/location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:fpdart/fpdart.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(prayersTimeProvider).when(data: ((data) {
      final timings = data.timings;
      final keys = timings.keys;
      final values = timings.values;
      final date = data.date["readable"];

      List<PrayerTimeHome> prayers = [];
      for (var i = 0; i < keys.length; i++) {
        if (keys.elementAt(i) == "Sunrise" ||
            keys.elementAt(i) == "Sunset" ||
            keys.elementAt(i) == "Imsak" ||
            keys.elementAt(i) == "Midnight" ||
            keys.elementAt(i) == "Firstthird" ||
            keys.elementAt(i) == "Lastthird") {
          continue;
        }
        prayers.add(PrayerTimeHome(
          name: keys.elementAt(i),
          time: values.elementAt(i).toString().substring(0, 5),
        ));
      }

      final time = DateTime.now().toString().substring(11, 16);

      int index = 0;
      for (var i = 0; i < prayers.length; i++) {
        if (time.compareTo(prayers[i].time) < 0) {
          index = i;
          break;
        }
      }
      final nextPrayer = prayers[index].name;
      final nextPrayerTime = prayers[index].time;
      final timeLeft = prayers[index].time;
      final counter = Helper.getDifferenceInSeconds(time, timeLeft);
      DateTime counterDate;
     if (nextPrayer == "Fajr"){
         counterDate = Helper.getDateTimeFromFormattedTime(nextPrayerTime);
         // add one day to it
          counterDate = counterDate.add(const Duration(days: 1));
     }
      else{
        counterDate = Helper.getDateTimeFromFormattedTime(nextPrayerTime);
      }

      return Center(
        child: Column(
          children: [
            HomeDate(
              date: date,
            ),
            SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...prayers,
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Stack(children: [
              Container(
                  padding: EdgeInsets.all(12.0),
                  width: 400,
                  height: 160,
                  decoration: BoxDecoration(
                    color: Pallete.grayColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Next Prayer",
                            style: TextStyle(
                                color: Pallete.purpleColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Image.asset(
                            "assets/images/group.png",
                            width: 20,
                            height: 20,
                            color: Pallete.purpleColor,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        Helper.getFormattedTimeAMPM(nextPrayerTime),
                        style: TextStyle(
                            color: Pallete.purpleColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Time Left for $nextPrayer Prayer",
                        style: TextStyle(
                            color: Pallete.purpleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TimerCountdown(
                        descriptionTextStyle: TextStyle(color: Colors.transparent),
                        timeTextStyle: TextStyle(color: Pallete.purpleColor, fontSize: 18),
                        colonsTextStyle: TextStyle(color: Colors.white),
                        
                        format: CountDownTimerFormat.hoursMinutesSeconds,
                        endTime: counterDate,
                        onEnd: () {
                          print("Timer finished");
                        },
                      ),
                    ],
                  )),
              Positioned(
                child: Container(
                  height: 100,
                  width: 150,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/mosque.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                top: 60,
                left: 250,
              )
            ]),
            SizedBox(
              height: 50,
            ),
            Container(
              width: 400,
              height: 180,
              decoration: BoxDecoration(
                color: Pallete.grayColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "اللهم اهدني فيمن هديت، وعافني فيمن عافيت، وتولني فيمن توليت، وبارك لي فيما أعطيت، وقني شرَّ ما قضيت، فإنك تقضي ولا يقضى عليك، إنه لا يذل من واليت، ولا يُعزُّ من عاديتَ، تبارَكتَ ربَّنا وتعاليت",
                style: TextStyle(
                    color: Pallete.purpleColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
            )
          ],
        ),
      );
    }), error: (error, stackTrace) {
      return Center(
        child: Text(
          error.toString(),
          style: TextStyle(color: Colors.white),
        ),
      );
    }, loading: () {
      return Center(
        child: CircularProgressIndicator(
          color: Pallete.purpleColor,
        ),
      );
    });
  }
}
