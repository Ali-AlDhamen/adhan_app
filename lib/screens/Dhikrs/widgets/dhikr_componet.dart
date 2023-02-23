import 'package:flutter/material.dart';

import '../../../theme/pallete.dart';

class DhkirComponent extends StatelessWidget {
  String? dhkirText;
  String? dhkirCount;
  DhkirComponent({super.key, this.dhkirText, this.dhkirCount});



  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return  Container(
              width: width * 0.9,
              height: height * 0.08,
              margin: const EdgeInsets.only(top: 20.0),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Pallete.grayColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Row(
                     children: [
                       Text(
                        dhkirCount == null ? "0": dhkirCount!,
                        style: TextStyle(
                            color: Pallete.purpleColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                  ),

                  IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.add,
                          color: Pallete.purpleColor,
                        ),
                  ),

                  IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.settings_backup_restore_outlined,
                          color: Pallete.purpleColor,
                        ),
                  ),

                  IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.push_pin,
                          color: Pallete.purpleColor,
                        ),
                  ),
                     ],
                   ),

                   Text(
                    dhkirText!,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),);
  }}