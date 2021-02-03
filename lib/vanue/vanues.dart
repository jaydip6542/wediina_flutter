import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';

import 'package:wediina_bussniss/data/post_api_service.dart';
import 'package:wediina_bussniss/mainscreen/homepage.dart';


import 'package:wediina_bussniss/vanue/demovenudetail.dart';
import 'package:wediina_bussniss/vanue/vanue_detail.dart';
import 'package:wediina_bussniss/vanue/vanue_list.dart';
import 'package:wediina_bussniss/vendor/home_page.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';





class VanuesPage extends StatelessWidget {
  final String postId;

  VanuesPage({Key key, this.postId, }) : super(key: key);

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
        title: Text('Venues'),
        backgroundColor: Colors.redAccent[200],
      ),

      body: _buildBody(context),
    //  bottomNavigationBar: BottomNavBar(),

    );
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
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

          final List posts = json.decode(snapshot.data.bodyString);
          return _buildPosts(context, posts);
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
  Widget _buildPosts(BuildContext context, List posts) {
    return GridView.builder(

      itemCount: posts.length,
      padding: EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 7.0,
        mainAxisSpacing: 7.0,

      ),

      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return new GestureDetector(

          onTap: () => _navigateToPost(context, posts[index]['_id']),

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
                     child: Text(posts[index]['venue_cat_name'],
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
        );
      },
    );
  }

  void _navigateToPost(BuildContext context, String _id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VenueList(postId: _id),
      ),
    );
  }
}