import 'package:adhan_app/providers/fav_city_provider.dart';
import 'package:adhan_app/screens/favouriteCities/widgets/fav_city.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/spinkit.dart';
import '../../common/error.dart';

class FavoriteCities extends ConsumerWidget {
  const FavoriteCities({super.key});

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
              return const Error();
            }, loading: () {
              return const Center(child: spinKit);
            })
          ],
        ),
      ),
    );
  }
}
