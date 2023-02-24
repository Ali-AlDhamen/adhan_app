import 'package:adhan_app/models/prayers_time.dart';
import 'package:adhan_app/providers/city_name_provider.dart';
import 'package:adhan_app/providers/searched_city_provider.dart';
import 'package:adhan_app/services/location.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../services/prayers_api.dart';



final cityPrayersTimeProvider =
    FutureProvider.autoDispose<PrayersTime>((ref) async {
  String? searchedCity = ref.watch(searchedCityProvider);
  if (searchedCity == null) {
    Position position = await LocationAPI.determinePosition();
    List<String> city = await LocationAPI.getCityName(position);
    searchedCity = city[0];
  }
  List<String?> address =
      await LocationAPI().getCityAndCountryByAddress(searchedCity);
  ref.read(cityNameProvider.notifier).update((state) => address);
  
  final data = await PrayerApi().getPrayerTimes(address[0]!, address[1]!);
  int day = DateTime.now().day - 1;
  return data[day];
});
