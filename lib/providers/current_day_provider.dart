import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentDayProvider = StateProvider<int>((ref) {
  return DateTime.now().day - 1;
});
