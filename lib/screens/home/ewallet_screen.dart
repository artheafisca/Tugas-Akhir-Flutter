import 'package:e_wallet/model/color.dart';
import 'package:e_wallet/screens/home/chart_screen.dart';
import 'package:e_wallet/screens/home/home_screen.dart';
import 'package:e_wallet/screens/home/notif_screen.dart';
import 'package:e_wallet/screens/home/setting_screen.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class EwalletScreen extends StatefulWidget {
  const EwalletScreen({super.key});

  @override
  State<EwalletScreen> createState() => _EwalletScreenState();
}

class _EwalletScreenState extends State<EwalletScreen> {
  int index = 0;
  PageController pageController = new PageController();

  void onTap(int page) {
    setState(() {
      index - page;
    });
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(
        children: [
          PageView(
            controller: pageController,
            children: [
              HomeScreen(),
              ChartScreen(),
              NotifScreen(),
              Account()
            ],
            onPageChanged: (i) {
              setState(() {
                index = i;
              });
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FloatingNavbar(
              items: [
                FloatingNavbarItem(icon: Iconsax.home),
                FloatingNavbarItem(icon: Iconsax.chart),
                FloatingNavbarItem(icon: Iconsax.notification),
                FloatingNavbarItem(icon: Iconsax.setting),
              ],
              currentIndex: index,
              borderRadius: 24,
              iconSize: 26,
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(12),
              selectedBackgroundColor: Colors.transparent,
              selectedItemColor: primaryColor,
              unselectedItemColor: Colors.white70,
              backgroundColor: Colors.black87,
              onTap: onTap,
            ),
          ),
        ],
      ),
    ));
  }
}
