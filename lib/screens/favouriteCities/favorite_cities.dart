

import 'package:adhan_app/screens/favouriteCities/favorite_city.dart';
import 'package:flutter/material.dart';

class FavoriteCities extends StatelessWidget {
  const FavoriteCities({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Center(
      child: SizedBox(
        width: width * 0.9,
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                FavoriteCity.route(context, "Riyadh");
              },
              child: Container(
                  width: width * 0.9,
                  height: height * 0.15,
                  padding: EdgeInsets.all(10),
                  margin: const EdgeInsets.only(top: 20.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/riyadh.jpeg'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Riyadh", style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold, color: Colors.white),),
                      IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_rounded, color: Colors.white , size: 30,))
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
