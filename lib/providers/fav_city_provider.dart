import 'package:adhan_app/services/hive_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final favCityProvider = FutureProvider.autoDispose<List<dynamic>>((ref) {
  return HiveAPi.getFavCities();
});

