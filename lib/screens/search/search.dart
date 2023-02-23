import 'package:adhan_app/screens/test.dart';
import 'package:adhan_app/theme/pallete.dart';
import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  const Search({super.key});

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
            child: const TextField(
              style: TextStyle(color: Colors.white),
              cursorColor: Pallete.purpleColor,
              decoration: InputDecoration(
                border: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: Pallete.purpleColor),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.05,
          ),
          
      
        ],
      ),
    );
  }
}
