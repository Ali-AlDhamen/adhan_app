import 'package:adhan_app/screens/Dhikrs/widgets/dhikr_componet.dart';
import 'package:flutter/material.dart';
import "DhikrsList.dart";
import '../../theme/pallete.dart';

class Dhikrs extends StatelessWidget {
  const Dhikrs({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Center(
      child: SizedBox(
        width: width * 0.9,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: dhkirs.length,
                itemBuilder: (context, index) {
                  return DhkirComponent(
                    dhkirText: dhkirs[index],
                    dhkirCount: "0",
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
