import 'package:e_wallet/model/color.dart';
import 'package:e_wallet/screens/auth/login.dart';
import 'package:e_wallet/screens/home/ewallet_screen.dart';
import 'package:flutter/material.dart';

import '../model/widget.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    _checkUserSementara();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
              child: Image.asset(
                "images/logo.png",
                fit: BoxFit.contain,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 50),
            //   child: wAppLoading(),
            // )
          ],
        ),
      ),
    );
  }

  void _checkUserSementara() async {
    await Future.delayed(Duration(seconds: 2));

    wPushReplaceTo(context, Login());
  }
}
