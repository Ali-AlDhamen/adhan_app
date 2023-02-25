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

  Future<Map<String, dynamic>> getPrayerTimesByCity(
      String city, String country) async {
    final year = DateTime.now().year;
    final month = DateTime.now().month;
    final response = await Dio().get(
        '$calenderByCity/$year/$month?city=$city&country=$country&method=8');

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
}
