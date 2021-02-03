import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wediina_bussniss/buttomnavigationbar/bottomnavigation2.dart';
import 'package:wediina_bussniss/buttomnavigationbar/buttomnavigationbar.dart';
import 'package:wediina_bussniss/splashscreen/splash.dart';

void main() => runApp(new MyApp65953221());

class MyApp65953221 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      color: Colors.blue,
      home: new Splash(),
    );
  }
}

class Splash extends StatefulWidget {
  @override
  SplashState createState() => new SplashState();
}

class SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => BottomNavBar0(),
        ),
      );
    } else {
      await prefs.setBool('seen', true);
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => Splash12(),
        ),
      );
    }
  }

  @override
  void afterFirstLayout(BuildContext context) => checkFirstSeen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
//      body: new Center(
//        child: new Text('Loading...'),
//      ),
    );
  }
}

