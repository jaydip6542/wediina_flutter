import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:wediina_bussniss/vanue/vanue_list.dart';
import 'package:wediina_bussniss/vendor/vendor_list.dart';


class Homescreen12 extends StatefulWidget {

  Homescreen12({Key key}) : super(key: key);

  @override
  HomescreenState createState() => HomescreenState();


}
class HomescreenState extends State<Homescreen12> {
  String id;
  int _currentIndex = 2;
  int page = 0;
  ScrollController _scrollController;
  var _isVisible;

  List venue = [];
  List vendor = [];


  getCountries() async {
    var response = await http.get('https://api-wediina.herokuapp.com/vendor_cat');
    final posts1 = json.decode(response.body );
    return posts1;
  }

  @override
  void initState() {
    getVenus().then((posts) {
      setState(() {
        venue  = posts;
      });
    });

    getCountries().then((posts1) {
      setState(() {
        vendor  = posts1;
      });
    });


    super.initState();
  }




  getVenus() async {
    var response = await http.get('https://api-wediina.herokuapp.com/venue_cat');
    final posts = json.decode(response.body );
    return posts;
  }


  GlobalKey _bottomNavigationKey = GlobalKey();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wediina'),
        backgroundColor: Colors.redAccent[200],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: 20,
            margin: EdgeInsets.only(left:20.0,top: 5 ),
            child: Text("Venue",
              style: TextStyle(color: Colors.black,fontSize: 20,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5 ),
            height: 150,
            child: venue.length > 0
              ? GridView.builder(
              itemCount: venue.length,
              padding: EdgeInsets.all(8),
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                crossAxisSpacing: 7.0,
                mainAxisSpacing: 7.0,
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return new GestureDetector(

                  onTap: () => _navigateToVenus(context, venue[index]['_id']),

                  child: Container(
                    height: 100,

                    child: Stack(

                      children: <Widget>[

                        //   margin: Edge//Insets.only(right: 10),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:  BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(venue[index]['image'],),
                                  fit: BoxFit.fill
                              )
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius:  BorderRadius.circular(10),
                              gradient: LinearGradient(
                                //begin: Alignment.bottomRight,
                                  colors: [
                                    Colors.black.withOpacity(.5),
                                    Colors.black.withOpacity(.5),

                                  ]
                              )
                          ),
                        ),
                        Container(
                          child: Align(
                            alignment: Alignment.center,

                            child: Text(venue[index]['venue_cat_name'],
                              textAlign: TextAlign.right,
                              maxLines: 3,
                              style: TextStyle(color: Colors.white,fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                  ),
                );
              },
            )
            :  Center(
              child: GlowingProgressIndicator(
               child: Image.asset('assets/loader.png', width: 30.0, height: 30.0),
                ),
                 ),
          ),
          Container(
            height: 20,
            margin: EdgeInsets.only(left:20.0,top: 5 ),
            child: Text("Vendor",
              style: TextStyle(color: Colors.black,fontSize: 20,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5 ),
            height: 450,
             child: vendor.length > 0
              ? AnimationLimiter(
          child: GridView.builder(
            itemCount: vendor.length,
            padding: EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 7.0,
              mainAxisSpacing: 7.0,

            ),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 700),
                child: SlideAnimation(
                  verticalOffset: 50.0,
                  child: SlideAnimation(
                    child: GestureDetector(
                      onTap: () => _navigateToVendor(context, vendor[index]['_id']),

                      child: Container(
                        height: 100,

                        child: Stack(

                          children: <Widget>[

                            //   margin: Edge//Insets.only(right: 10),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image: NetworkImage(vendor[index]['image'],),
                                      fit: BoxFit.fill
                                  )
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    //begin: Alignment.bottomRight,
                                      colors: [
                                        Colors.black.withOpacity(.5),
                                        Colors.black.withOpacity(.5),
                                      ]
                                  )
                              ),
                            ),
                            Container(

                              child: Align(
                                alignment: Alignment.center,
                                child: Text(vendor[index]['vendor_cat_name'],
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  style: TextStyle(color: Colors.white, fontSize: 20,
                                  ),
                                ),
                              ),

                            ),
                          ],
                        ),

                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          )
            :  Center(
            child: GlowingProgressIndicator(
            child: Image.asset('assets/loader.png', width: 30.0, height: 30.0),
              ),
              ),
          ),
        ],
      ),


    );
  }




  void _navigateToVendor(BuildContext context, String _id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VendorList(postId: _id),
      ),
    );
  }


  void _navigateToVenus(BuildContext context, String _id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VenueList(postId: _id),
      ),
    );
  }

}








