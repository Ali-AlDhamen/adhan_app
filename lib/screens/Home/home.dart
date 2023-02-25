import 'package:adhan_app/common/helper.dart';
import 'package:adhan_app/providers/prayers_time_provider.dart';

import 'package:adhan_app/screens/Home/widgets/home_date.dart';
import 'package:adhan_app/screens/Home/widgets/prayer_time_home.dart';
import 'package:adhan_app/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

import '../../common/spinkit.dart';
import '../../common/error.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    // get width and height
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return ref.watch(prayersTimeProvider).when(data: ((data) {
      final date = data.date["readable"];
      List<PrayerTimeHome> prayers = Helper.getPrayerTimeHome(data);
      final nextPrayer = Helper.getNextPrayer(prayers);
      DateTime counterDate = Helper.getCountDate(nextPrayer);

      return Center(
        child: Column(
          children: [
            HomeDate(
              date: date,
            ),
            SizedBox(
              height: height * 0.03,
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
              height: height * 0.06,
            ),
            Stack(children: [
              Container(
                  padding: const EdgeInsets.all(12.0),
                  width: width * 0.95,
                  height: height * 0.17,
                  decoration: BoxDecoration(
                    color: Pallete.grayColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text(
                            "Next Prayer",
                            style: TextStyle(
                                color: Pallete.purpleColor,
                                fontSize: 16,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: width * 0.01,
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
                        height: height * 0.01,
                      ),
                      Text(
                        Helper.getFormattedTimeAMPM(nextPrayer.time),
                        style: const TextStyle(
                            color: Pallete.purpleColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      Text(
                        "Time Left for ${nextPrayer.name} Prayer",
                        style: const TextStyle(
                            color: Pallete.purpleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      SizedBox(
                        height: height * 0.01,
                      ),
                      TimerCountdown(
                        descriptionTextStyle:
                            const TextStyle(color: Colors.transparent),
                        timeTextStyle: const TextStyle(
                            color: Pallete.purpleColor, fontSize: 18),
                        colonsTextStyle: const TextStyle(color: Colors.white),
                        format: CountDownTimerFormat.hoursMinutesSeconds,
                        endTime: counterDate,
                        onEnd: () {},
                      ),
                    ],
                  )),
              Positioned(
                top: height * 0.06,
                left: width * 0.6,
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
              )
            ]),
            SizedBox(
              height: height * 0.05,
            ),
            Container(
              width: width * 0.95,
              height: height * 0.2,
              decoration: BoxDecoration(
                color: Pallete.grayColor,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              child: const Text(
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
      return Error();
    }, loading: () {
      return const Center(child: spinKit);
    });
  }
}
