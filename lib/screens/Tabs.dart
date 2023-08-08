import 'package:adhan_app/screens/Dhikrs/Dhikrs.dart';
import 'package:adhan_app/screens/Home/home.dart';
import 'package:adhan_app/screens/favouriteCities/Favorite_cities.dart';
import 'package:adhan_app/screens/search/search.dart';
import 'package:adhan_app/theme/pallete.dart';
import 'package:fluid_bottom_nav_bar/fluid_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

class Tabs extends StatefulWidget {
  static route(BuildContext context, int index) {
    GoRouter.of(context).go('/tabs/$index');
  }


 
  int index = 0;
  Tabs(this.index, {super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  Widget _child = const Home();
  void _handleNavigationChange(int index) {
    GoRouter.of(context).go('/tabs/$index');
  }
  @override
  void initState() {
    super.initState();
    _handleNavigationChange(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title:  Text('قم صل', style: GoogleFonts.reemKufi(
          color: Pallete.purpleColor,
          fontSize: 30,
          fontWeight: FontWeight.bold,
        )),
        backgroundColor:  Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      backgroundColor: Pallete.blackColor,
      body: _child,
      bottomNavigationBar: FluidNavBar(
       
        
        style: const FluidNavBarStyle(
          barBackgroundColor: Pallete.grayColor,
          iconSelectedForegroundColor: Pallete.purpleColor,
        ),
        
        onChange: _handleNavigationChange,
        icons: [
          FluidNavBarIcon(
            icon: Icons.home,
          ),
          FluidNavBarIcon(
            icon: Icons.search,
          ),
          FluidNavBarIcon(
            icon: Icons.book,
          ),
          FluidNavBarIcon(
            icon: Icons.favorite,
          ),
        ],
      ),
    );
  }
}