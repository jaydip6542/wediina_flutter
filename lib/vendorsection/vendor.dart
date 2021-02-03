import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:chopper/chopper.dart';
import 'package:wediina_bussniss/data/post_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:wediina_bussniss/vendor/vendor_list.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:provider/provider.dart';


import 'package:wediina_bussniss/vendor/single_post_page.dart';


class Vendors extends StatefulWidget {

  const Vendors({Key key}) : super(key: key);



  @override
  VendorsState createState() => new VendorsState();

}

class VendorsState extends State<Vendors> {


  GlobalKey _bottomNavigationKey = GlobalKey();

  List filteredCountries = [];
  bool isSearching = false;
  List vendor = [];



  getVenus() async {
    var response = await http.get('https://api-wediina.herokuapp.com/vendor_cat');
    final posts = json.decode(response.body );
    return posts;
  }

  @override
  void initState() {
    getVenus().then((posts) {
      setState(() {
        vendor = filteredCountries  = posts;
      });
    });
    super.initState();
  }

  void _filterCountries(value) {
    setState(() {
      filteredCountries = vendor
          .where((vendor) =>
          vendor['vendor_cat_name'].toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.redAccent[200],
        title: !isSearching
            ? Text(' Vendor')
            : TextField(
          onChanged: (value) {
            _filterCountries(value);
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
              icon: Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: "Search Vendor Here",
              hintStyle: TextStyle(color: Colors.white)),
        ),
        actions: <Widget>[
          isSearching
              ? IconButton(
            icon: Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                this.isSearching = false;
                filteredCountries = vendor;
              });
            },
          )
              : IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                this.isSearching = true;
              });
            },
          )
        ],
      ),
      body:Container(
          child: filteredCountries.length > 0
              ? AnimationLimiter(
            child: GridView.builder(
              itemCount: filteredCountries.length,
              padding: EdgeInsets.all(8),
              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 7.0,
                mainAxisSpacing: 7.0,

              ),
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 700),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FlipAnimation(
                      child: GestureDetector(
                        onTap: () => _navigateToPost(context, filteredCountries[index]['_id']),

                        child: Container(
                          height: 100,

                          child: Stack(

                            children: <Widget>[

                              //   margin: Edge//Insets.only(right: 10),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius:  BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: NetworkImage(filteredCountries[index]['image'],),
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
                                  child: Text(filteredCountries[index]['vendor_cat_name'],
                                    textAlign: TextAlign.center,
                                    maxLines: 3,
                                    style: TextStyle(color: Colors.white,fontSize: 20,
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



     // _buildPosts(context,vendor),

    );
  }



  //
//  FutureBuilder<Response> _buildBody(BuildContext context) {
//    // FutureBuilder is perfect for easily building UI when awaiting a Future
//    // Response is the type currently returned by all the methods of PostApiService
//    return FutureBuilder<Response>(
//      // In real apps, use some sort of state management (BLoC is cool)
//      // to prevent duplicate requests when the UI rebuilds
//      future: Provider.of<PostApiService>(context).getVendors(),
//      builder: (context, snapshot) {
//        if (snapshot.connectionState == ConnectionState.done) {
//          if (snapshot.hasError) {
//            return Center(
//              child: Text(
//                snapshot.error.toString(),
//                textAlign: TextAlign.center,
//                textScaleFactor: 1.3,
//              ),
//            );
//          }
//
//          final  List posts = json.decode(snapshot.data.bodyString);
//          return _buildPosts(context, posts);
//        } else {
//          // Show a loading indicator while waiting for the posts
//          return Center(
//            child: GlowingProgressIndicator(
//              child: Image.asset('assets/loader.png', width: 30.0, height: 30.0),
//            ),
//          );
//        }
//      },
//    );
//  }

//  Widget _buildPosts(BuildContext context, vendor) {
//    return  AnimationLimiter(
//      child: GridView.builder(
//        itemCount: vendor.length,
//        padding: EdgeInsets.all(8),
//        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
//          crossAxisCount: 2,
//          crossAxisSpacing: 7.0,
//          mainAxisSpacing: 7.0,
//
//        ),
//        itemBuilder: (context, index) {
//          return AnimationConfiguration.staggeredList(
//            position: index,
//            duration: const Duration(milliseconds: 700),
//            child: SlideAnimation(
//              verticalOffset: 50.0,
//              child: FlipAnimation(
//                child: GestureDetector(
//                  onTap: () => _navigateToPost(context, vendor[index]['_id']),
//
//                  child: Container(
//                    height: 100,
//
//                    child: Stack(
//
//                      children: <Widget>[
//
//                        //   margin: Edge//Insets.only(right: 10),
//                        Container(
//                          decoration: BoxDecoration(
//                              borderRadius:  BorderRadius.circular(10),
//                              image: DecorationImage(
//                                  image: NetworkImage(vendor[index]['image'],),
//                                  fit: BoxFit.fill
//                              )
//                          ),
//                        ),
//                        Container(
//                          decoration: BoxDecoration(
//                              borderRadius:  BorderRadius.circular(10),
//                              gradient: LinearGradient(
//                                //begin: Alignment.bottomRight,
//                                  colors: [
//                                    Colors.black.withOpacity(.5),
//                                    Colors.black.withOpacity(.5),
//
//                                  ]
//                              )
//                          ),
//                        ),
//                        Container(
//                          child: Align(
//                            alignment: Alignment.center,
//                            child: Text(vendor[index]['vendor_cat_name'],
//                              textAlign: TextAlign.center,
//                              maxLines: 3,
//                              style: TextStyle(color: Colors.white,fontSize: 20,
//                              ),
//                            ),
//                          ),
//                        ),
//                      ],
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          );
//        },
//      ),
//    );
//
//  }


  void _navigateToPost(BuildContext context, String _id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VendorList(postId: _id),
      ),
    );
  }

}
