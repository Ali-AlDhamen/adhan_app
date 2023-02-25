import 'package:adhan_app/screens/Home/widgets/prayer_time_home.dart';
import 'package:adhan_app/screens/search/widgets/prayer_time.dart';

class Helper {
  static String getFormattedTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  static String getFormattedTimeAMPM(String time) {
    var timeSplit = time.split(':');
    var hour = int.parse(timeSplit[0]);
    var minute = int.parse(timeSplit[1]);
    var ampm = 'AM';
    if (hour > 12) {
      hour = hour - 12;
      ampm = 'PM';
    }

    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $ampm';
  }

  static int getDifferenceInSeconds(String time1, String time2) {
    var time1Split = time1.split(':');
    var time2Split = time2.split(':');
    var time1Hour = int.parse(time1Split[0]);
    var time1Minute = int.parse(time1Split[1]);
    var time2Hour = int.parse(time2Split[0]);
    var time2Minute = int.parse(time2Split[1]);
    var time1Seconds = time1Hour * 3600 + time1Minute * 60;
    var time2Seconds = time2Hour * 3600 + time2Minute * 60;
    return time2Seconds - time1Seconds;
  }

  static String getFormattedTimeFromSeconds(int seconds) {
    var hour = (seconds / 3600).floor();
    var minute = ((seconds % 3600) / 60).floor();
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }

  static DateTime getDateTimeFromFormattedTime(String time) {
    var timeSplit = time.split(':');
    var hour = int.parse(timeSplit[0]);
    var minute = int.parse(timeSplit[1]);
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day, hour, minute);
  }

  static List<PrayerTimeHome> getPrayerTimeHome(data) {
    final timings = data.timings;
    final keys = timings.keys;
    final values = timings.values;

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
    return prayers;
  }

  static PrayerTimeHome getNextPrayer(List<PrayerTimeHome> prayers) {
    final time = DateTime.now().toString().substring(11, 16);

    int index = 0;
    for (var i = 0; i < prayers.length; i++) {
      if (time.compareTo(prayers[i].time) < 0) {
        index = i;
        break;
      }
    }
    return prayers[index];
  }

  static DateTime getCountDate(PrayerTimeHome nextPrayer) {
    DateTime counterDate;
    if (nextPrayer.name == "Fajr") {
      counterDate = Helper.getDateTimeFromFormattedTime(nextPrayer.time);
      counterDate = counterDate.add(const Duration(days: 1));
    } else {
      counterDate = Helper.getDateTimeFromFormattedTime(nextPrayer.time);
    }
    return counterDate;
  }

  static List<PrayerTime> getPrayerTimes(data, height, width) {
    final timings = data.timings;
    final keys = timings.keys;
    final values = timings.values;

    List<PrayerTime> prayers = [];
    for (var i = 0; i < keys.length; i++) {
      if (keys.elementAt(i) == "Sunrise" ||
          keys.elementAt(i) == "Sunset" ||
          keys.elementAt(i) == "Imsak" ||
          keys.elementAt(i) == "Midnight" ||
          keys.elementAt(i) == "Firstthird" ||
          keys.elementAt(i) == "Lastthird") {
        continue;
      }
      prayers.add(PrayerTime(
        height: height,
        width: width,
        prayer: keys.elementAt(i),
        time: getFormattedTimeAMPM(
            values.elementAt(i).toString().substring(0, 5)),
      ));
    }
    return prayers;
  }

  static void sortDhikrs(data) {
    data.sort((a, b) {
      if (a["isPinned"] == true && b["isPinned"] == false) {
        return -1;
      } else if (a["isPinned"] == false && b["isPinned"] == true) {
        return 1;
      } else {
        return 0;
      }
    });
  }
}
