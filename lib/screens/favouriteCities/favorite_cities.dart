import 'package:adhan_app/providers/fav_city_provider.dart';
import 'package:adhan_app/screens/favouriteCities/fav_city.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../theme/pallete.dart';

class FavoriteCities extends ConsumerWidget {
  const FavoriteCities({super.key});

  void ss() async {
    final box = await Hive.openBox('favCities');
    box.deleteAll(box.keys.toList());
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.of(context).size.width;

    return Center(
      child: SizedBox(
        width: width * 0.9,
        child: Column(
          children: [
            ref.watch(favCityProvider).when(data: (data) {
        
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return FavCity(cityName: data[index]["cityName"]);
                  },
                ),
              );
            }, error: (error, stackTrace) {
              return Center(
                child: Text(
                  error.toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }, loading: () {
              return const Center(
                child: CircularProgressIndicator(
                  color: Pallete.purpleColor,
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
