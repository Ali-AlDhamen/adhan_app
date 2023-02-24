import 'package:adhan_app/providers/current_day_provider.dart';
import 'package:adhan_app/services/prayers_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:adhan_app/models/prayers_time.dart';
import 'package:geolocator/geolocator.dart';

import '../services/location.dart';

final prayersTimeProvider =
    FutureProvider.autoDispose<PrayersTime>((ref) async {
  Position position = await LocationAPI.determinePosition();
  List<String> city = await LocationAPI.getCityName(position);
  final data = await PrayerApi().getPrayerTimes(city[0], city[1]);
  int day = ref.watch(currentDayProvider);
  return data[day];
});
