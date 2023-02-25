import 'package:adhan_app/services/hive_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final dhkirsProvider = FutureProvider.autoDispose<List<dynamic>>((ref) {

  return HiveAPi.getDhikrs();
});

