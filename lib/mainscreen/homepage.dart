import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/rendering.dart';

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wediina_bussniss/businessprofile/businessprofile_page.dart';
import 'package:wediina_bussniss/buttomnavigationbar/bottomnavigation2.dart';
import 'package:wediina_bussniss/buttomnavigationbar/buttomnavigationbar1.dart';
import 'package:wediina_bussniss/data/post_api_service.dart';
import 'package:wediina_bussniss/loginsingup/business_login.dart';

import 'package:wediina_bussniss/whiselistpage/testingwhiselist.dart';


void main(){
  runApp(
      MaterialApp(
      )

  );

}

class Homescreen extends StatefulWidget {

  Homescreen({Key key}) : super(key: key);

  @override
  HomescreenState createState() => HomescreenState();


}
class HomescreenState extends State<Homescreen> {
  String id;
  int _currentIndex = 2;
  int page = 0;
  ScrollController _scrollController;
  var _isVisible;

//  @override
//  void initState() {
//
//    super.initState();
//    _loadCounter();
//  }
//
//  _loadCounter() async {
//    final  prefs = await SharedPreferences.getInstance();
//    var myStringBus = (prefs.getString('my_string_keyBus')??'');
//    String id = myStringBus;
//    print(id);
//   }


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
            child: _buildvenues(context),
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
        child: _buildBody(context),
      ),
        ],
      ),
    );
  }


  FutureBuilder<Response> _buildBody(BuildContext context) {
    // FutureBuilder is perfect for easily building UI when awaiting a Future
    // Response is the type currently returned by all the methods of PostApiService
    return FutureBuilder<Response>(
      // In real apps, use some sort of state management (BLoC is cool)
      // to prevent duplicate requests when the UI rebuilds
      future: Provider.of<PostApiService>(context).getVendors(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          }

          final  List posts = json.decode(snapshot.data.bodyString);
          return _buildPosts(context, posts);
        } else {
          // Show a loading indicator while waiting for the posts
          return Center(
            child: GlowingProgressIndicator(
              child: Image.asset('assets/loader.png', width: 40.0, height: 40.0),
            ),
          );
        }
      },
    );
  }

  Widget _buildPosts(BuildContext context, List posts) {
    return AnimationLimiter(
      child: GridView.builder(
        itemCount: posts.length,
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
                  onTap: () => _navigateToVendor(context, posts[index]['_id']),

                  child: Container(
                    height: 100,

                    child: Stack(

                      children: <Widget>[

                        //   margin: Edge//Insets.only(right: 10),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(posts[index]['image'],),
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
                          child: Text(posts[index]['vendor_cat_name'],
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
    );
  }
  void _navigateToVendor(BuildContext context, String _id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VendorList(postId: _id),
      ),
    );
  }



  FutureBuilder<Response> _buildvenues(BuildContext context) {
    // FutureBuilder is perfect for easily building UI when awaiting a Future
    // Response is the type currently returned by all the methods of PostApiService
    return FutureBuilder<Response>(
      // In real apps, use some sort of state management (BLoC is cool)
      // to prevent duplicate requests when the UI rebuilds
      future: Provider.of<PostApiService>(context).getVenues(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                snapshot.error.toString(),
                textAlign: TextAlign.center,
                textScaleFactor: 1.3,
              ),
            );
          }

          final  List posts = json.decode(snapshot.data.bodyString);
          return _buildVenus(context, posts);
        } else {
          // Show a loading indicator while waiting for the posts
          return Center(
            child: GlowingProgressIndicator(
              child: Image.asset('assets/loader.png', width: 30.0, height: 30.0),
            ),
          );
        }
      },
    );
  }

  Widget _buildVenus(BuildContext context, List posts) {
    return GridView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(8),
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 1,
        crossAxisSpacing: 7.0,
        mainAxisSpacing: 7.0,

      ),

      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return new GestureDetector(

          onTap: () => _navigateToVenus(context, posts[index]['_id']),

          child: Container(
            height: 100,

            child: Stack(

              children: <Widget>[

                //   margin: Edge//Insets.only(right: 10),
                Container(
                  decoration: BoxDecoration(
                      borderRadius:  BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(posts[index]['image'],),
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

                  child: Text(posts[index]['venue_cat_name'],
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








