import 'package:adhan_app/providers/dkhirs_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/Dhikr.dart';

class HiveAPi {
  static Future<List<dynamic>> getDhikrs() async {
    final box = await Hive.openBox('dhkirs');
    List<dynamic> dhikrs = [];
    for (int i = 0; i < box.length; i++) {
      dhikrs.add(box.getAt(i));
    }
    return dhikrs;
  }

  static Future<void> increaseDhkirCounter(String dhkirName) async {
    final box = await Hive.openBox('dhkirs');
    for (int i = 0; i < box.length; i++) {
      if (box.getAt(i)["dhkirName"] == dhkirName) {
        box.putAt(i, {
          'dhkirName': dhkirName,
          'dhkirCount': box.getAt(i)["dhkirCount"] + 1,
          'isPinned': box.getAt(i)["isPinned"],
        });
      }
    }
  }

  static Future<void> resetDhkirCounter() async {
    final box = await Hive.openBox('dhkirs');
    for (int i = 0; i < box.length; i++) {
      box.putAt(i, {
        'dhkirName': box.getAt(i)["dhkirName"],
        'dhkirCount': 0,
        'isPinned': box.getAt(i)["isPinned"],
      });
    }
  }

  static Future<void> pinDhkir(String dhkirName) async {
    final box = await Hive.openBox('dhkirs');
    for (int i = 0; i < box.length; i++) {
      if (box.getAt(i)["dhkirName"] == dhkirName) {
        box.putAt(i, {
          'dhkirName': dhkirName,
          'dhkirCount': box.getAt(i)["dhkirCount"],
          'isPinned': !box.getAt(i)["isPinned"],
        });
      }
    }
  }

  static Future<void> addCityToFav(String cityName) async {
    // check if already Exists
    final box = await Hive.openBox('favCities');
    for (int i = 0; i < box.length; i++) {
      if (box.getAt(i)["cityName"] == cityName) {
        return;
      }
    }
    box.add({"cityName": cityName});
  }

  static Future<void> removeCityToFav(String cityName) async {
    final box = await Hive.openBox('favCities');
    for (int i = 0; i < box.length; i++) {
      if (box.getAt(i)["cityName"] == cityName) {
        box.deleteAt(i);
      }
    }
  }

  static Future<List<dynamic>> getFavCities() async {
    final box = await Hive.openBox('favCities');
    List<dynamic> favCities = [];
    for (int i = 0; i < box.length; i++) {
      favCities.add(box.getAt(i));
    }
    return favCities;
  }

  static Future<bool> isFav(String cityName) async {
    final box = await Hive.openBox('favCities');
    for (int i = 0; i < box.length; i++) {
      if (box.getAt(i)["cityName"] == cityName) {
        return true;
      }
    }
    return false;
  }
}
