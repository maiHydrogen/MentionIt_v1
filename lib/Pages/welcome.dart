import 'dart:async';
import 'dart:developer';
import 'package:baatcheet/api/api.dart';
import 'package:flutter/material.dart';
import 'package:baatcheet/pages/homepage.dart';
import 'package:baatcheet/pages/sign_in.dart';
import 'package:flutter/services.dart';
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
            image: AssetImage('Images/SplashBC5.jpg'),
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
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
        SystemChrome.setSystemUIOverlayStyle(
            const SystemUiOverlayStyle(statusBarColor: Colors.transparent)
        );
        if (isLoggedIn != null) {
          if(APIs.auth.currentUser != null){
            log('\nUser: ${APIs.auth.currentUser}');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MyHome()),
            );
          }
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