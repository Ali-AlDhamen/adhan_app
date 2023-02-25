// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adhan_app/providers/current_day_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../theme/pallete.dart';

class HomeDate extends ConsumerWidget {
  final String date;
  const HomeDate({super.key, required this.date});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: Pallete.purpleColor, size: 30),
          onPressed: () {
            ref.read(currentDayProvider.notifier).update((state) => state - 1);
          },
        ),
        Row(
          children: [
            const Icon(Icons.calendar_month_rounded,
                color: Pallete.purpleColor, size: 30),
            const SizedBox(
              width: 10,
            ),
            Text(
              date,
              style: const TextStyle(
                  color: Pallete.purpleColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios_rounded,
              color: Pallete.purpleColor, size: 30),
          onPressed: () {
            ref.read(currentDayProvider.notifier).update((state) => state + 1);
          },
        ),
      ],
    );
  }
}
