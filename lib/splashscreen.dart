// ignore_for_file: prefer_const_constructors, avoid_print

import 'dart:async';
import 'package:flutter/material.dart';
import './main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './auth/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int _value = 0;

  @override
  void initState() {
    super.initState();
    _loadCounter();
    startSplashScreen();
  }

  _loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getInt('value'));
    setState(() {
      _value = (prefs.getInt('value') ?? 0);
    });
  }

  startSplashScreen() async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () {
      if (_value.toInt() == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  MainPage(title: 'SIPP | PUSDATIN - KEMHAN')),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      }

      // Navigator.of(context).;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: const [
                Color(0xFFffd000),
                Color(0xFFff9500),
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: <Widget>[
                const Image(
                  image: AssetImage("assets/images/splash.png"),
                  width: 150,
                ),
                const SizedBox(height: 24.0),
                const Text(
                  'LEMBIMJAR',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Arial',
                    color: Colors.white,
                  ),
                ),
                const Text(
                  'Lembaga Bimbingan Belajar',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Arial',
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "version: 1.0.0",
                  style: TextStyle(
                    fontSize: 10,
                    fontFamily: 'Arial',
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
