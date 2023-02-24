import 'package:adhan_app/services/hive_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/Dhikr.dart';

final dhkirsProvider = FutureProvider<List<dynamic>>((ref) {
  
  return HiveAPi.getDhikrs();
});

