
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:wediina_bussniss/filterpage/whishlist.dart';
import 'package:wediina_bussniss/loginsingup/business_login.dart';

import 'package:wediina_bussniss/mainscreen/mainscreentating.dart';
import 'package:wediina_bussniss/vanuesection/venus.dart';
import 'package:wediina_bussniss/vendorsection/vendor.dart';
//import 'package:flutter_appwithapi/businessprofile/businessprofile_page.dart';
//import 'package:flutter_appwithapi/conditioncheck/businessprofilechek.dart';
//import 'package:flutter_appwithapi/conditioncheck/logincheck.dart';
//import 'package:flutter_appwithapi/customer_profile/customer_profile_page.dart';
//import 'package:flutter_appwithapi/filterpage/whishlist.dart';
//import 'package:flutter_appwithapi/filterpage/whishlist1.dart';
//import 'package:flutter_appwithapi/loginsingup/custmorlogin.dart';
//import 'package:flutter_appwithapi/mainscreen/homepage.dart';
//import 'package:flutter_appwithapi/mainscreen/mainscreentating.dart';
//import 'package:flutter_appwithapi/vanue/vanues.dart';
//import 'package:flutter_appwithapi/vanuesection/venus.dart';
//import 'package:flutter_appwithapi/vendor/home_page.dart';
//import 'package:flutter_appwithapi/vendorsection/vendor.dart';

void main() => runApp(MaterialApp(home: BottomNavBar()));

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 0;
  int _currentIndex = 2 ;
  GlobalKey _bottomNavigationKey = GlobalKey();




  final tabs = [

    Vendors(
      key: PageStorageKey('Page1'),
    ),

    VenusPage(
      key: PageStorageKey('Page2'),

    ),
    Homescreen12(
      key: PageStorageKey('Page3'),

    ),
    WhishList(
      key: PageStorageKey('Page4'),

    ),
    Loginbusiness(
      key: PageStorageKey('Page5'),

    ),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: _currentIndex,
          height: 50.0,
          items: <Widget>[
            Icon(Icons.shopping_cart, size: 30),
            Icon(Icons.event_seat, size: 30),
            Icon(Icons.home, size: 30),
            Icon(Icons.call, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.redAccent[200],
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        body: tabs[_currentIndex],
    );
  }
}

