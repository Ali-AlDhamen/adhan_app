import 'package:adhan_app/services/hive_api.dart';
import 'package:flutter/material.dart';

import 'favorite_city.dart';

class FavCity extends StatelessWidget {
  final String cityName;
  const FavCity({Key? key, required this.cityName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FavoriteCity.route(context, "Riyadh");
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
                cityName,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              IconButton(
                  onPressed: () async {
                    await HiveAPi.removeCityToFav(cityName);
                  },
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.red,
                    size: 30,
                  ))
            ],
          )),
    );
  }
}
