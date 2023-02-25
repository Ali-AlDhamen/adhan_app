import 'package:adhan_app/theme/pallete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';


class Error extends StatelessWidget {
  const Error({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 100),
          SvgPicture.asset(
            'assets/images/error.svg',
            height: 200,
            width: 200,
          ),
          const SizedBox(height: 20),
           Text(
            'Something went wrong',
            style: GoogleFonts.openSans(
              color: Pallete.purpleColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
           Text(
            'Please try again later',
            style: GoogleFonts.openSans(
              color: Pallete.purpleColor,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
            )
        ],
      ),
    );
  }
}