
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:wediina_bussniss/filterpage/whishlist.dart';
import 'package:wediina_bussniss/loginsingup/business_login.dart';

import 'package:wediina_bussniss/mainscreen/mainscreentating.dart';
import 'package:wediina_bussniss/vanuesection/venus.dart';
import 'package:wediina_bussniss/vendorsection/vendor.dart';


void main() => runApp(MaterialApp(home: BottomNavBar1()));

class BottomNavBar1 extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar1> {
  int _page = 0;
  int _currentIndex = 1 ;
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
          Icon(Icons.call_split, size: 30),
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










//
//import 'dart:convert';
//
//import 'package:chopper/chopper.dart';
//import 'package:curved_navigation_bar/curved_navigation_bar.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
//import 'package:flutter_appwithapi/customer_profile/customer_profile_page.dart';
//import 'package:flutter_appwithapi/data/post_api_service.dart';
//import 'package:flutter_appwithapi/mainscreen/homepage.dart';
//import 'package:flutter_appwithapi/profile/profilepage.dart';
//import 'package:flutter_appwithapi/vanue/vanues.dart';
//import 'package:flutter_appwithapi/vendor/home_page.dart';
//import 'package:flutter_appwithapi/vendor/viewmorephotosvendor.dart';
//import 'package:provider/provider.dart';
//import 'package:carousel_slider/carousel_slider.dart';
//import 'package:share/share.dart';
//import 'package:youtube_player/youtube_player.dart';
//
//class BottomNavBar extends StatefulWidget {
//  // final String postId;
//
//
//  BottomNavBar({
//    Key key,
//
//  }) : super(key: key);
//  @override
//  _YoutubeState createState() => _YoutubeState();
//
////  @override
////  BottomNavBarState createState() => BottomNavBarState();
//
//}
//class _YoutubeState extends State<BottomNavBar> {
//
//  GlobalKey _bottomNavigationKey = GlobalKey();
//  int _currentIndex = 0;
//  void onTabTapped(int index){
//    setState(() {
//      _currentIndex = index;
//    });
//  }
//
//  final tabs = [
//
//    VanuesPage(
//      key: PageStorageKey('Page1'),
//    ),
//
//    HomePage(
//      key: PageStorageKey('Page2'),
//
//    ),
//    Homescreen(
//      key: PageStorageKey('Page3'),
//
//    ),
//    VanuesPage(
//      key: PageStorageKey('Page4'),
//
//    ),
//    VanuesPage(
//      key: PageStorageKey('Page5'),
//
//    ),
//  ];
//
//
//  @override
//  Widget build(BuildContext context) {
//
//    return
//      MaterialApp(
//        debugShowCheckedModeBanner: false,
//
//    home: Scaffold(
//      body: tabs[_currentIndex],
//
//      bottomNavigationBar: BottomNavigationBar(
//          type: BottomNavigationBarType.fixed,
//          currentIndex: _currentIndex,
//          onTap: onTabTapped,
//          fixedColor: Colors.red,
//          iconSize: 24.0,
//          items: [
//            BottomNavigationBarItem(
//              icon: Icon(Icons.home),
//              title: Text('Home'),
//            ),
//            BottomNavigationBarItem(
//              icon: Icon(Icons.whatshot),
//              title: Text('Trending'),
//            ),
//            BottomNavigationBarItem(
//              icon: Icon(Icons.favorite),
//              title: Text('Subscriptions'),
//            ),
//            BottomNavigationBarItem(
//              icon: Icon(Icons.folder),
//              title: Text('Library'),
//            ),
//          ]),
//    ),
//    );
//
//
//  }
//
//}




//class BottomNavBarState extends State<BottomNavBar> {

//  int _currentIndex = 0;
//  int page = 0;
//  ScrollController _scrollController;
//  var _isVisible;



//  final tabs = [
//
//    HomePage(
//      key: PageStorageKey('Page1'),
//    ),
//
//    VanuesPage(
//      key: PageStorageKey('Page2'),
//
//    ),
//    Homescreen(
//      key: PageStorageKey('Page3'),
//
//    ),
//    ProfilePage(
//      key: PageStorageKey('Page4'),
//
//    ),
//    Customerprofilepage(
//      key: PageStorageKey('Page5'),
//
//    ),
//  ];
//
//
// // GlobalKey _bottomNavigationKey = GlobalKey();
//
//
//  @override
//  Widget build(BuildContext context) {
//    return
//
//       CurvedNavigationBar(
//        key: _bottomNavigationKey,
//
//
//        height: 40.0,
//         items: <Widget>[
//           IconButton(icon: Icon(Icons.people,size: 20), onPressed: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => HomePage(),
//               ),
//             );
//           },),
//           IconButton(icon: Icon(Icons.local_hotel,size: 20), onPressed: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => VanuesPage(),
//               ),
//             );
//           },),
//           IconButton(icon: Icon(Icons.home,size: 20), onPressed: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => Homescreen(),
//               ),
//             );
//           },),
//
//           IconButton(icon: Icon(Icons.person,size: 20), onPressed: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => ProfilePage(),
//               ),
//             );
//           },),
//
//           IconButton(icon: Icon(Icons.people,size: 20), onPressed: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => Customerprofilepage(),
//               ),
//             );
//           },),
//
//
//         ],
//        color: Colors.white,
//        buttonBackgroundColor: Colors.white,
//        backgroundColor: Colors.redAccent[100],
//        animationCurve: Curves.easeInOutCubic,
//        animationDuration: Duration(milliseconds: 600),
//
////        onTap: (index) {
////          setState(() {
////
////
////          });
////        },
//      );
//
//
//
//  }
//}







//import 'package:flutter/material.dart';
//import 'package:curved_navigation_bar/curved_navigation_bar.dart';
//import 'package:flutter/rendering.dart';
//import 'package:flutter_appwithapi/customer_profile/customer_profile_page.dart';
//import 'package:flutter_appwithapi/mainscreen/homepage.dart';
//import 'package:flutter_appwithapi/profile/profilepage.dart';
//import 'package:flutter_appwithapi/vanue/vanues.dart';
//import 'package:flutter_appwithapi/vendor/home_page.dart';
//
//void main() => runApp(MaterialApp(home: BottomNavBar()));
//
//class BottomNavBar extends StatefulWidget {
//  @override
//  _BottomNavBarState createState() => _BottomNavBarState();
//}
//
//class _BottomNavBarState extends State<BottomNavBar> {
//  int _currentIndex = 0;
//  int _page = 0;
//  ScrollController _scrollController;
//  var _isVisible;
//
//  @override
//  void initState() {
//    super.initState();
//    _scrollController = ScrollController();
//    _scrollController.addListener(() {
//      if (_scrollController.position.userScrollDirection ==
//          ScrollDirection.reverse) {
//        //  setState(() => _visible = false);
//
//        if(_isVisible)
//          setState(() {
//            _isVisible = false;
//            print("**** $_isVisible up");
//          });
//
//
//
//      }
//
//      if (_scrollController.position.userScrollDirection ==
//          ScrollDirection.forward) {
//
//        if(!_isVisible)
//          setState(() {
//            _isVisible = true;
//            print("**** $_isVisible down");
//          });
//
//
//
//      }
//    });
//  }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

//
//
//  GlobalKey _bottomNavigationKey = GlobalKey();
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//
//      body: tabs[_currentIndex],
//      bottomNavigationBar: CurvedNavigationBar(
//        key: _bottomNavigationKey,
//        index: _currentIndex,
//        height: 50.0,

//        color: Colors.white,
//        buttonBackgroundColor: Colors.white,
//        backgroundColor: Colors.redAccent[100],
//        animationCurve: Curves.easeInOut,
//        animationDuration: Duration(milliseconds: 600),
//        onTap: (index) {
//          setState(() {
//            _currentIndex = index;
//          });
//        },
//      ),
//
//    );
//  }
//}