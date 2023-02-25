import 'package:adhan_app/providers/searched_city_provider.dart';
import 'package:adhan_app/services/hive_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Tabs.dart';


class FavCity extends ConsumerStatefulWidget {
  final String cityName;
  const FavCity({Key? key, required this.cityName}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavCityState();
}

class _FavCityState extends ConsumerState<FavCity> {
  bool deleted = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        ref
            .read(searchedCityProvider.notifier)
            .update(((state) => widget.cityName));
        Tabs.route(context, 1);
      },
      child: Container(
          width: width * 0.9,
          height: height * 0.15,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.only(top: 20.0),
          decoration: BoxDecoration(
            image: const DecorationImage(
              image: AssetImage('assets/images/prayertime.png'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.cityName,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              IconButton(
                  onPressed: () async {
                    await HiveAPi.removeCityToFav(widget.cityName);
                    setState(() {
                      deleted = true;
                    });
                  },
                  icon: Icon(
                    deleted ? Icons.favorite_border : Icons.favorite,
                    color: deleted ? Colors.white : Colors.red,
                    size: 30,
                  ))
            ],
          )),
    );
  }
}
