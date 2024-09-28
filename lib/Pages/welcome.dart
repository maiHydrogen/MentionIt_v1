import 'dart:async';
import 'package:flutter/material.dart';
import 'package:baatcheet/pages/homepage.dart';
import 'package:baatcheet/pages/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Welcomepage extends StatefulWidget {
  const Welcomepage({super.key});

  @override
  State<Welcomepage> createState() => WelcomepageState();
}

class WelcomepageState extends State<Welcomepage> {
  static const String keylogin = "login";
  @override
  void initState() {
    super.initState();
    moveToNext();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("lib/Images/SplashBC.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        width: double.infinity,
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'A proud',
              style: TextStyle(
                  fontFamily: 'Solitreo', fontSize: 16, color: Colors.white),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'MAKE IN INDIA',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.normal,
                fontSize: 24,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Product',
              style: TextStyle(
                  fontFamily: 'Solitreo', fontSize: 16, color: Colors.white),
            ),
            SizedBox(
              height: 80,
            ),
          ],
        ),
      ),
    );
  }

  void moveToNext() async {
    var sharedPref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedPref.getBool(keylogin);

    Timer(
      const Duration(seconds: 3),
      () {
        if (isLoggedIn != null) {
          if (isLoggedIn) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MyHome()),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SignIn()),
            );
          }
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignIn()),
          );
        }
      },
    );
    setState(() {});
  }
}