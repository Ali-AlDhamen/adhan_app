import 'package:adhan_app/models/prayers_time.dart';
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'dart:convert';

class PrayerApi {
  static const apiUrl = 'http://api.aladhan.com/v1/';
  static const calenderByCity = "$apiUrl/calendarByCity";
  static Future<Map<String, dynamic>> getMonthOfPrayerTimes(
      String longitude, String latitude) async {
    final year = DateTime.now().year;
    final month = DateTime.now().month;

    final response = await Dio().get(
        "http://api.aladhan.com/v1/calendar/$year/$month?latitude=$latitude&longitude=$longitude&method=8");
    final data = json.decode(response.data);
    if (response.statusCode == 200) {
      return data;
    } else {
      throw Exception('Failed to load data!');
    }
  }

  Future<Map<String, dynamic>> getPrayerTimesByCity(String city ,String country) async {
    final year = DateTime.now().year;
    final month = DateTime.now().month;
    final response = await Dio().get('$calenderByCity/$year/$month?city=$city&country=$country&method=8');

  
    final data = response.data;
    if (response.statusCode == 200) {
      return data;
    } else {
      if (response.statusCode == 400) {
        throw Exception('City not found!');
      } else {
        throw Exception('Failed to load data!');
      }
    }
  }

  Future<List<PrayersTime>> getPrayerTimes(city, country) async {
    var data = await getPrayerTimesByCity(city, country);
    final List<PrayersTime> prayerTimes = [];
    for (var i = 0; i < data['data'].length; i++) {
      prayerTimes.add(PrayersTime.fromJson(data['data'][i]));
    }
    return prayerTimes;
  }

  Future<MapEntry<String, DateTime>> getNextPrayer(city, country) async {
    var data = await getPrayerTimes(city, country);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    for (var i = 0; i < data.length; i++) {
      var dayMonthYear =
          DateFormat('dd-MM-yyyy').parse(data[i].date['gregorian']['date']);
      var finalFormatted =
          DateFormat('yyyy-MM-dd').parse(dayMonthYear.toString());
      final date = DateTime.parse(finalFormatted.toString());
      if (date == today) {
        final timings = data[i].timings;
        var timeFormat = DateFormat('HH:mm');
        var listOfTimes = <String, DateTime>{};
        timings.forEach((key, value) {
          var time = timeFormat.parse(value);
          var finalTime = DateTime(date.year, date.month, date.day, time.hour,
              time.minute, time.second);
          listOfTimes.addEntries([MapEntry(key, finalTime)]);
        });
        var returnList = <String, DateTime>{};
        listOfTimes.forEach((key, value) {
          if (value.isAfter(now)) {
            var nextPrayer = key;
            var nextPrayerTime = value;
            returnList.addEntries([MapEntry(nextPrayer, nextPrayerTime)]);
          }
        });
        try {
          var entry = returnList.entries.first;
          return entry;
        } catch (e) {
          return MapEntry("NONE", DateTime.now());
        }
      }
    }
    return MapEntry("NONE", DateTime.now());
  }

  Future<MapEntry<String, DateTime>> getNextPrayerTomorrow(
      city, country) async {
    var data = await getPrayerTimesByCity(city, country);
    final now = DateTime.now();

    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    if (tomorrow.month > now.month) {
      data = await getPrayerTimesByCity(city, country);
    }
    for (var i = 0; i < data.length; i++) {
      var dayMonthYear =
          DateFormat('dd-MM-yyyy').parse(data[i].date['gregorian']['date']);
      var finalFormatted =
          DateFormat('yyyy-MM-dd').parse(dayMonthYear.toString());
      final date = DateTime.parse(finalFormatted.toString());
      if (date == tomorrow) {
        final timings = data[i].timings;
        var timeFormat = DateFormat('HH:mm');
        var listOfTimes = <String, DateTime>{};
        timings.forEach((key, value) {
          var time = timeFormat.parse(value);
          var finalTime = DateTime(date.year, date.month, date.day, time.hour,
              time.minute, time.second);
          listOfTimes.addEntries([MapEntry(key, finalTime)]);
        });
        var returnList = <String, DateTime>{};
        listOfTimes.forEach((key, value) {
          if (value.isAfter(now)) {
            var nextPrayer = key;
            var nextPrayerTime = value;
            returnList.addEntries([MapEntry(nextPrayer, nextPrayerTime)]);
          }
        });
        try {
          var entry = returnList.entries.first;
          return entry;
        } catch (e) {
          return MapEntry("NONE", DateTime.now());
        }
      }
    }
    return MapEntry("NONE", DateTime.now());
  }
}
