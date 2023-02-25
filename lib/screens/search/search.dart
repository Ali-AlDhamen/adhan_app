import 'package:adhan_app/common/helper.dart';
import 'package:adhan_app/providers/city_name_provider.dart';
import 'package:adhan_app/providers/city_prayers_provider.dart';
import 'package:adhan_app/providers/searched_city_provider.dart';
import 'package:adhan_app/services/hive_api.dart';
import 'package:adhan_app/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/spinkit.dart';
import 'widgets/prayer_time.dart';
import '../../common/error.dart';

class Search extends ConsumerStatefulWidget {
  const Search({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SearchState();
}

class _SearchState extends ConsumerState<Search> {
  bool isFav = false;
  TextEditingController addressController = TextEditingController();
  String cityName = " ";
  String countryName = "";

  @override
  void dispose() {
    super.dispose();
    addressController.dispose();
  }

  void isFavorite() async {
    bool fav = await HiveAPi.isFav(cityName);
    setState(() {
      isFav = fav;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Center(
      child: Column(
        children: [
          Container(
            width: width * 0.9,
            height: height * 0.05,
            margin: const EdgeInsets.only(top: 20.0),
            decoration: BoxDecoration(
              color: Pallete.grayColor,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: TextField(
              controller: addressController,
              style: const TextStyle(color: Colors.white),
              cursorColor: Pallete.purpleColor,
              decoration: const InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Pallete.purpleColor),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.white),
              ),
              onSubmitted: (value) {
                cityName = value;
                ref
                    .read(searchedCityProvider.notifier)
                    .update((state) => value);
              },
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          ref.watch(cityPrayersTimeProvider).when(data: ((data) {
            List<PrayerTime> prayers =
                Helper.getPrayerTimes(data, height, width);
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      ref.watch(cityNameProvider) != []
                          ? "${ref.watch(cityNameProvider)[0]}, ${ref.watch(cityNameProvider)[1]}"
                          : "",
                      style: const TextStyle(
                          color: Pallete.purpleColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    FutureBuilder(
                        future: HiveAPi.isFav(
                            ref.watch(cityNameProvider)[0].toString()),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return IconButton(
                              icon: Icon(
                                snapshot.data!
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Pallete.purpleColor,
                              ),
                              onPressed: () async {
                                if (snapshot.data!) {
                                  await HiveAPi.removeCityToFav(ref
                                      .watch(cityNameProvider)[0]
                                      .toString());
                                } else {
                                  await HiveAPi.addCityToFav(ref
                                      .watch(cityNameProvider)[0]
                                      .toString());
                                }
                                setState(() {});
                              },
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        })
                  ],
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                ...prayers
              ],
            );
          }), error: (error, stackTrace) {
            return const Error();
          }, loading: () {
            return const Center(child: spinKit);
          })
        ],
      ),
    );
  }
}
